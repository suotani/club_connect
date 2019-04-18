Rails.application.routes.draw do
  
  root to: "static#index"

  get "privacy", to: 'static#privacy'

  devise_for :members, controllers: {
    sessions: 'members/sessions',
    unlocks: 'members/unlocks',
    registrations: 'members/registrations',
    passwords: 'members/passwords',
    confirmations: 'members/confirmations',
  }
  
  resources :todos, only: [:index]
  
  get 'home', to: "home#index"
  get 'new', to: 'home#new'
  get 'edit', to: 'home#edit'
  post 'create', to: 'home#create'
  post 'update', to: 'home#update'
  
  namespace :api do
    resources :todos
    
    resources :members
    
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
    
    resources :requests, only: [:create, :update, :destroy]
    
    resources :contacts, only: [:index, :show, :create, :update]
    
    get 'dashboard', to: "dashboard#index"
    get 'dashboard-info', to: 'dashboard#show'
    post 'inquiry', to: "inquiry#create"
  end
end
