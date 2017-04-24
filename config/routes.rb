Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/register', to: 'users#new'
  resources :users, only: [:create, :destroy]

  root to: 'main#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :tools do
    resources :reviews
  end

  resources :rentals, only: [:create, :show]

end
