Rails.application.routes.draw do



  devise_scope :user do
    root :to => 'devise/sessions#new'
  end
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks"}
  resources :users
  resources :interests
  # get 'users/:id' => 'users#show'
  # get '/users' => 'users#index'
  

  post '/get_meetup_info' => 'pages#get_meetup_info'

  post '/save_interest' => 'users#save_interest'
  delete '/remove_interest' => 'users#remove_interest'

  resources :chats do
  resources :messages
  end

  # direct to chat room
  get '/events/:id' => 'event#show', as: 'event'

  post '/unsubscribe/:id' => 'chats#leavechat'

end
