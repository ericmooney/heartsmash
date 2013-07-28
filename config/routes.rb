Heartsmash::Application.routes.draw do
  get 'search' => 'users#index', :as => "search"

  get 'messages/:user_id' => 'messages#show'
  get 'messages/:user_id/new' => 'messages#new'
  post 'messages/:user_id' => 'messages#create'

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  resources :messages, :except => [:edit, :update, :destroy]
  resources :user_sessions, :except => [:index, :show, :edit, :update]
  resources :users
  resources :subscriptions

  root :to => 'users#index'


end
