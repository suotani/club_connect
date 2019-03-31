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
    @team = Team.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
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
      :school, :category_id, :introduction, :members, :leader_name, :leader_email,
      :leader_role, :sub_leader_name, :sub_leader_email, :sub_leader_role, :school_type, images: []
    )
  end
end
