class TeamController < ApplicationController
    
    def current_team
        Team.find(1)
    end
end