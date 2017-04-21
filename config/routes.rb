Rails.application.routes.draw do
  
  get '/register', to: 'users#new'
  resources :users, only: [:create, :destroy]

  root to: 'tools#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :tools do
    resources :reviews
  end
end
