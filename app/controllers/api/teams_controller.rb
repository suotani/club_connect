class Api::TeamsController < ApiController
  def index
    @teams = Team.eager_load(:category)
    @teams = @teams.where("school like ?", "%#{params[:school]}%") if params[:school].present?
    @teams = @teams.where(category_id: params[:category_id]) if params[:category_id].present?
    @teams = @teams.where(school_type: params[:school_type]) if params[:school_type].present?
    @total_team_count = @teams.count
    @teams = @teams.page(params[:page]).per(10)
    
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
  
  def show
    @current_date = Time.zone.today
    @team = Team.find(params[:id])
    @current_calender = @team.calenders.where(year: @current_date.year, month: @current_date.month).first
    if @current_calender.blank?
      @current_calender = Calender.create(team_id: @team.id, year: @current_date.year, month: @current_date.month)
    end
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
  
  def calender
    # TODO: ログインチームのみ
    @team = Team.find(1)
    render_calender_json
  end
  
  def change_calender
    @team = Team.find(params[:id])
    render_calender_json
  end
  
  def calender_add_event
    @team = Team.find(1)
    if params[:schedule][:id]
      @schedule = Schedule.find(params[:schedule][:id])
    else
      year, month = params[:schedule][:date].split("/")
      calender = @team.calenders.where(year: year, month: month).first
      @schedule = Schedule.create(calender_id: calender.id, day: params[:schedule][:day])
    end
    Event.create(schedule_id: @schedule.id, text: params[:schedule][:text])
    render json: {result: "success", schedule_id: @schedule.id}
  end
  
  def setting
    # TODO: ログインチームのみ
    @team = Team.find(1)
    render 'setting', formats: 'json', handlers: 'jbuilder'
  end
  
  def setting_update
    @team = Team.find(1)
    if @team.update(team_params)
      render json: {result: "success"}
    else
      render json: {result: "error", errors: @team.errors.full_messages}
    end
  end
  
  def file_upload
    @team = Team.find(1)
    image = @team.images.attach(params[:file])[0]
    render json: {result: "success", id: image.id}
  end
  
  def file_delete
    ActiveStorage::Attachment.find(params[:id]).purge
    render json: {result: "success"}
  end
  
  private
  
  def team_params
    params.require(:team).permit(
      :school, :name, :category_id, :introduction, :members, :leader_name, :leader_email,
      :leader_role, :sub_leader_name, :sub_leader_email, :sub_leader_role, :school_type, images: []
    )
  end
  
  def render_calender_json
    @current_date = Date.parse(params[:date] || Time.zone.today.strftime("%Y/%m"))
    @current_calender = @team.calenders.where(year: @current_date.year, month: @current_date.month).first
    if @current_calender.blank?
      @current_calender = Calender.create(team_id: @team.id, year: @current_date.year, month: @current_date.month)
    end
    render 'change_calender', formats: 'json', handlers: 'jbuilder'
  end
end
