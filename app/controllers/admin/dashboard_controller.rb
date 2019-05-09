class Admin::DashboardController < TeamController
  
  before_action :check_admin
  
  def index
    @total_member = Member.count
    @total_team = Team.count
    @category_count = Team.group(:category_id).count.to_a
  end
  
  private
  
  def check_admin
    unless current_member.admin
      redirect_to home_path
    end
  end
end