Rails.application.routes.draw do

  # using for testing chat
  get 'users/index'


  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks"}

  resources :interests
 # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#welcome'

  post '/get_meetup_info' => 'pages#get_meetup_info'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'


  devise_for :users

  get '/' => 'users#index'


  resources :conversations do
    resources :messages
  end
end
