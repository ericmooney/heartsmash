Heartsmash::Application.routes.draw do
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  resources :user_sessions, :except => [:index, :show, :edit, :update]
  resources :users


  root :to => 'users#index'


end
