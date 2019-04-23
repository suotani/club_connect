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
  
  def edit
    @team = current_team
    render 'setting', formats: 'json', handlers: 'jbuilder'
  end
  
  def update
    @team = current_team
    if @team.update(team_params)
      render json: {result: "success"}
    else
      render json: {result: "error", errors: @team.errors.full_messages}
    end
  end
  
  def candidates
    @members = current_team.members
    @members = @members.where("name like ?", "%#{params[:name]}%") if params[:name].present?
    render json: {members: @members}
  end
  
  def update_leader
    if params[:type] == "leader" && current_team.members.ids.include?(params[:leader_id])
      current_team.update!(leader_id: params[:leader_id])
      render json: {leader: current_team.leader}
    elsif params[:type] == "subleader" && current_team.members.ids.include?(params[:leader_id])
      current_team.update!(subleader_id: params[:leader_id])
      render json: {subleader: current_team.subleader}
    end
  end
  
  private
  
  def team_params
    params.require(:team).permit(
      :school, :name, :category_id, :introduction, :members, :leader_name, :leader_email,
      :leader_role, :sub_leader_name, :sub_leader_email, :sub_leader_role, :school_type, images: []
    ).tap do |v|
      v[:exec_valid] = true
    end
  end
end
