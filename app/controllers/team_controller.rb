class TeamController < ApplicationController
    before_action :authenticate_member!
    
    
    def current_team
        current_member.team
    end
end