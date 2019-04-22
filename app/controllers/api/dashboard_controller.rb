class Api::DashboardController < ApiController
  
  def index
    @schedules = Schedule.where(calender_id: current_team.calenders.map(&:id))
                         .where(id: Event.all.map(&:schedule_id).uniq)
                         .where("date >= ?", Time.zone.today)
                         .order(date: :asc)
                         .limit(5)
    @teams = Team.where.not(school: nil).order(created_at: :desc).limit(5)
    @request_count = Contact.request_message
                            .where(to_team_id: current_team.id)
                            .where(request_status: nil)
                            .count
    @no_read_to_contact_count = Contact.where(to_team_id: current_team.id)
                                       .to_team_no_read
                                       .count
    @no_read_from_contact_count = Contact.where(from_team_id: current_team.id)
                                         .from_team_no_read
                                         .count
    @no_read_contact_count = @no_read_to_contact_count + @no_read_from_contact_count
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
  
  def show
    teams = current_member.teams.uniq
    render json: {team: current_team, teams: teams}
  end
  
  def update
    team = current_member.teams.find(params[:id])
    current_member.update(team_id: team.id)
    render json: {}
  end
end