json.set! :message do
  json.id         @message.id
  json.from_team  @message.from_team
  json.created_at @message.created_at.strftime("%Y/%m/%d %H:%M")
  json.short_text @message.text[0..50]
  json.text       @message.text
end