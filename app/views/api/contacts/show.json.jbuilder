json.messages do
  json.array! @contact.messages.order(:created_at) do |m|
    json.id         m.id
    json.from_team  m.from_team
    json.created_at m.created_at.strftime("%Y/%m/%d %H:%M")
    json.short_text m.text[0..50]
    json.text       m.text
  end
end

json.set! :contact do
  json.id             @contact.id
  json.title          @contact.title
  json.schedule_id    @contact.schedule_id
  json.requesting     @contact.request_message? && @contact.request_status.nil?
  if @contact.schedule_id
    json.set! :schedule do
      json.date           @contact.schedule.date
      json.team_name      @target_team.school + " " + (@target_team.name || "")
      json.target_team_id @target_team.id
    end
  else
    json.set! :schedule do
      json.date           ""
      json.team_name      ""
      json.target_team_id ""
    end
  end
end