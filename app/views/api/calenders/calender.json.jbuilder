json.schedules do
  dates = @current_calender.schedules.map(&:day)
  json.array! 1.upto(@current_date.end_of_month.day) do |d|
    if dates.include?(d)
      s = @current_calender.schedules.find_by(day: d)
      json.day d
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