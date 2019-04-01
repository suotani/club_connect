Rails.application.routes.draw do
  
  root to: "static#index"

  get "privacy", to: 'static#privacy'

  devise_for :teams, controllers: {
    sessions: 'teams/sessions',
    unlocks: 'teams/unlocks',
    registrations: 'teams/registrations',
    passwords: 'teams/passwords',
    confirmations: 'teams/confirmations',
  }
  
  resources :todos, only: [:index]
  
  get 'home', to: "home#index"
  
  namespace :api do
    resources :todos
    
    resources :teams, only: [:index, :show] do
      collection do
        get 'edit'
        post 'update'
      end
    end
    
    resources :files, only: [:create, :destroy]
    
    resources :calenders, only: [:index, :show] do
      collection do
        post "update"
      end
    end
    
    resources :schedules, only: [] do
      collection do
        post "update"
      end
    end
    
    resources :requests, only: [:create]
  end
end
