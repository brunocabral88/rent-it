Rails.application.routes.draw do
  
  root to: 'tools#index'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

end
