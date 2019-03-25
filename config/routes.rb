Rails.application.routes.draw do
  #resources :todos, only: [:index]
  
  root to: "todos#index"
  
  namespace :api do
    resources :todos
  end
end
