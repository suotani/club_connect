class HomeController < TeamController
    def index
      redirect_to new_path unless current_team
    end
    
    def new
    end
    
    def create
    end
    
    def edit
    end
    
    def update
    end
    
end
