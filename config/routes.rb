Rails.application.routes.draw do

  devise_scope :user do
    root :to => 'devise/sessions#new'
  end
  
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks"}
  resources :users

  resources :interests
  get '/users' => 'users#index'
  post '/get_meetup_info' => 'pages#get_meetup_info'

  resources :chats do
    resources :messages
  end

end
