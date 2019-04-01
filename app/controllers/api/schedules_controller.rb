class Api::SchedulesController < ApiController
  
  def update
    if params[:id]
      @schedule = Schedule.find(prams[:id])
      @schedule.update(request: params[:request])
    else
      year, month = params[:date].split("/")
      calender = current_team.calenders.where(year: year, month: month).first
      Schedule.create(day: params[:day], request: params[:request], calender_id: calender.id)
    end
    render json: {result: "success"}
  end
end