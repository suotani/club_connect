class HomeController < TeamController
    protect_from_forgery
    skip_before_action :verify_authenticity_token
    def index
      redirect_to new_path unless current_team
    end
    
    def new
      @member = current_member
    end
    
    def search
      @team = Team.find_by(invite_code: params[:invite_code])
      render 'search', formats: 'json', handlers: 'jbuilder'
    end
    
    def create
      @member = current_member
      @team = Team.new(team_params(@member))
      if @team.save
        current_member.update(team_id: @team.id)
        MemberTeam.create(team_id: @team.id, member_id: current_member.id)
        render json: {result: "success"}
      else
        render json: {result: "fail", errors: @team.errors.full_messages}
      end
    end
    
    def show
      render 'show', formats: 'json', handlers: 'jbuilder'
    end
    
    def edit
    end
    
    def update
      team = Team.where(invite_code: params[:invite_code]).find(params[:id])
      unless team.members.include?(current_member)
        current_member.update!(team_id: team.id)
        MemberTeam.create!(team_id: team.id, member_id: current_member.id)
      end
     render json: {result: "success"}
    end
    
    
    private
    
    def team_params(m)
      params.require(:team).permit(:school, :name, :category_id, :school_type).tap do |v|
        v[:leader_id] = m.id
        v[:invite_code] = Team.generate_invite_code
      end
    end
end
