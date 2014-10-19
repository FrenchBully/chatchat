Rails.application.routes.draw do
 
  get 'users/index'

  devise_for :users

  get '/' => 'users#index'


  resources :conversations do
    resources :messages
  end
end
