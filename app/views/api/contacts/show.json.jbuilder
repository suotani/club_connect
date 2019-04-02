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
  json.title @contact.title
end