Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/register', to: 'users#new'
  get '/dashboard', to: 'main#dashboard'
  resources :users, only: [:create, :destroy]
  resource :cart, only: [:show] do
    put :add_item
    delete :delete_item
  end

  root to: 'main#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :tools do
    resources :reviews
  end
  patch :upload_tool_pic, to: 'tools#upload_tool_pic'

  resources :rentals, only: [:create, :show]

  post "/rentals/return", to: "rentals#final_charge_and_refund", as: :rental_return

end
