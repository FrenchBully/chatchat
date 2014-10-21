Rails.application.routes.draw do

<<<<<<< HEAD
  devise_scope :user do
    root :to => 'devise/sessions#new'
  end
  
=======
  root 'pages#welcome'
  # devise_for :users, controllers: { sessions: "sessions"}
>>>>>>> 76247461876b9045d69e382e96048f8e35859dbd
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks"}
  resources :users

  resources :interests
  get '/users' => 'users#index'
  post '/get_meetup_info' => 'pages#get_meetup_info'

  resources :chats do
    resources :messages
  end

end
