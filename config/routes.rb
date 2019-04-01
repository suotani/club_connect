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
    post '/teams/file_upload', to: 'teams#file_upload'
    get '/teams/file_delete', to: 'teams#file_delete'
    get '/teams/:id/change_calender', to: "teams#change_calender"
    resources :teams
    get '/setting', to: "teams#setting"
    post '/setting_update', to: "teams#setting_update"
    get '/calender', to: "teams#calender"
    post '/calender_add_event', to: "teams#calender_add_event"
  end
end
