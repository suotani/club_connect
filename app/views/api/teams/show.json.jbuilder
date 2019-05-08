json.set! :team do
  json.id @team.id
  json.school  @team.school
  json.category  @team.category.name
  json.members  @team.members_info
  json.introduction  @team.introduction
  json.address (@team.prefecture || "") + (@team.city || "") + (@team.address || "")
  json.leader_email  @team.leader.email
  json.leader_name  @team.leader.name
  json.leader_role  @team.leader.role_in_team
  json.sub_leader_name  @team.subleader.name
  json.sub_leader_email  @team.subleader.email
  json.sub_leader_role  @team.subleader.role_in_team
end

json.images do
  json.array! @team.images do |image|
    json.id image.id
    json.url url_for(image)
  end
end

json.schedules do
  dates = @current_calender.schedules.map(&:day)
  json.array! 1.upto(@current_date.end_of_month.day) do |d|
    if dates.include?(d)
      s = @current_calender.schedules.find_by(day: d)
      json.day d
      json.id s.id
      json.events do
        json.array! s.events do |e|
          json.text      e.text
          json.team_id   e.team_id
          json.team_name e.team.present? ? e.team.school + " " + (e.team.name || "") : ""
        end
      end
      json.request s.request
    else
      json.day d
      json.events []
      json.request false
    end
  end
end

json.currentDate @current_date.strftime("%Y/%m")
json.prevMonth (@current_date - 1.month).strftime("%Y/%m")
json.nextMonth (@current_date + 1.month).strftime("%Y/%m")