class Api::MembersController < ApiController
  
  def index
    @members = current_team.members
    @members = @members.where(grade: params[:grade]) if params[:grade].present?
    @members = @members.where("name like ?", "%#{params[:name]}%") if params[:name].present?
    @members_count = @members.count
    @members = @members.page(params[:page]).per(20)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
  
  def create
    mails = params[:mails].split(",")
    #TODO send mail
    mails.each do |mail|
      MemberInviteMailer.invite(mail, current_team, current_member).deliver_now
    end
    render json: {invite_count: mails.size}
  end
  
  def setting
    render json: {
      member: current_member,
      teams: current_member.teams,
      avatar_url: current_member.avatar.attached? ? url_for(current_member.avatar) : "",
      roles: Member::ROLE
    }
  end
  
  def update
    current_member.update!(member_params)
    render json: {result: "success"}
  end
  
  def upload
    current_member.avatar.purge
    image = current_member.avatar.attach(params[:file])
    render json: {result: "success", url: url_for(current_member.avatar)}
  end
  
  private
  
  def member_params
    params.require(:member).permit(:name, :role_in_team, :grade, :profile)
  end
end