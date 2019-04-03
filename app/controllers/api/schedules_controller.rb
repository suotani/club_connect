class Api::SchedulesController < ApiController
  
  def update
    if params[:id]
      @schedule = Schedule.find(prams[:id])
      @schedule.update(request: params[:request])
    else
      year, month = params[:date].split("/")
      calender = current_team.calenders.where(year: year, month: month).first
      date = Date.parse("#{year}/#{month}/#{params[:day]}")
      Schedule.create(day: params[:day], request: params[:request], calender_id: calender.id, date: date)
    end
    render json: {result: "success"}
  end
end