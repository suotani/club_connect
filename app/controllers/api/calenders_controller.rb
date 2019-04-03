class Api::CalendersController < ApiController
  def index
    @team = current_team
    render_calender_json
  end
  
  def update
    @team = current_team
    schedule_params= params[:schedule]
    if schedule_params[:id]
      @schedule = Schedule.find(schedule_params[:id])
    else
      year, month = schedule_params[:date].split("/")
      calender = @team.calenders.where(year: year, month: month).first
      date = Date.parse("#{calender.year}/#{calender.month}/#{schedule_params[:day]}")
      @schedule = Schedule.create(calender_id: calender.id, day: schedule_params[:day], date: date)
    end
    Event.create(schedule_id: @schedule.id, text: schedule_params[:text])
    render json: {result: "success", schedule_id: @schedule.id}
  end
  
  def show
    @team = Team.find(params[:id])
    render_calender_json
  end

  def render_calender_json
    @current_date = Date.parse(params[:date] || Time.zone.today.strftime("%Y/%m"))
    @current_calender = @team.calenders.where(year: @current_date.year, month: @current_date.month).first
    if @current_calender.blank?
      @current_calender = Calender.create(team_id: @team.id, year: @current_date.year, month: @current_date.month)
    end
    render 'calender', formats: 'json', handlers: 'jbuilder'
  end
end