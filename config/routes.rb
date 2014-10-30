Rails.application.routes.draw do

  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks"}
  
  # For all non-Devise user pages
  resources :users
  resources :interests


  post '/users/:id/edit' => 'users#update_interest'

  post '/get_meetup_info' => 'pages#get_meetup_info'
  # Method for the user to select a location
  get '/select_location' => 'pages#select_location'
  # Saves user's interests using AJAX from the edit_user page
  post '/save_interest' => 'interests#save_interest'
  # Click on the X in the menu to remove a chat
  delete '/remove_chat/:id' => 'chats#destroy', as: 'remove_chat'

  resources :chats do
    resources :messages
  end

  # Direct the user to the chat room
  get '/events/:id' => 'events#show'
  resources :events
  # Clicking on main menu icon refreshes the menu contents
  get '/event_update' => 'chats#event_update'
  # Enought chatting for one day
  post '/unsubscribe/:id' => 'chats#leavechat'

end
