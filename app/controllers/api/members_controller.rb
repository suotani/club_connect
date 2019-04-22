class Api::MembersController < ApiController
  
  def index
    @members = current_team.members
    @members = @members.where(grade: params[:grade]) if params[:grade].present?
    @members = @members.where("name like ?", "%#{params[:name]}%") if params[:name].present?
    @members_count = @members.count
    @members = @members.page(params[:page]).per(20)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
  
  def setting
    render json: {member: current_member, teams: current_member.teams}
  end
  
  def update
  end
  
  def upload
  end
end