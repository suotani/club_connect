json.request_contacts do
  json.array! @request_contacts do |c|
    last_message = c.messages.order(created_at: :desc).first.text
    if @team.id == c.from_team_id
        status = c.from_team_status_before_type_cast
        destination = c.to_team.school + " " + c.to_team.name
    else
        status = c.to_team_status_before_type_cast
        destination = c.from_team.school + " " + c.from_team.name
    end

    json.id            c.id
    json.short_text    last_message[0..50]
    json.title         c.title
    json.tag           Contact::TAG[status]
    json.destination   destination
  end
end
json.requests_total_count   @request_contacts_count

json.normal_contacts do
  json.array! @normal_contacts do |c|
    last_message = c.messages.order(created_at: :desc).first.text
    if @team.id == c.from_team_id
        status = c.from_team_status_before_type_cast
        destination = c.to_team.school + " " + c.to_team.name.to_s
    else
        status = c.to_team_status_before_type_cast
        destination = c.to_team.school + " " + c.to_team.name.to_s
    end

    json.id            c.id
    json.short_text    last_message[0..50]
    json.title         c.title
    json.tag           Contact::TAG[status]
    json.destination   destination
  end
end
json.contacts_total_count   @normal_contacts_count