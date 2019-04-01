json.set! :team do
  json.id @team.id
  json.school  @team.school
  json.category  @team.category.name
  json.members  @team.members
  json.introduction  @team.introduction
  json.leader_email  @team.leader_email
  json.leader_name  @team.leader_name
  json.leader_role  @team.leader_role
  json.sub_leader_name  @team.sub_leader_name
  json.sub_leader_email  @team.sub_leader_email
  json.sub_leader_role  @team.sub_leader_role
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
      json.events s.events.map(&:text)
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