Rails.application.routes.draw do

  root 'pages#welcome'
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks"}
  resources :users

  resources :interests
  get '/users' => 'users#index'
  post '/get_meetup_info' => 'pages#get_meetup_info'

  resources :conversations do
    resources :messages
  end

end
