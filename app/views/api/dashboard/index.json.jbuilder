json.schedules do
  json.array! @schedules do |s|
    json.date s.date.strftime("%Y/%m/%d")
    json.events do
      json.array! s.events do |e|
        json.text    e.text
        json.team    (e.team_id ? e.team.school + " " + e.team.name : "")
        json.team_id e.team_id
      end
    end
  end
end

json.teams do
  json.array! @teams do |t|
    json.name         (t.school || "") + " " + (t.name || "")
    json.id           t.id
    json.created_at   t.created_at.strftime("%Y/%m/%d")
    json.introduction (t.introduction || "")[0..50]
  end
end

json.request_count @request_count
json.no_read_contact_count @no_read_contact_count