Rails.application.routes.draw do

  resources :rooms
  get 'rules/index'
  get 'profile/index'

  get 'my_friends', to: "users#my_friends"
  get 'search_friends', to: "users#search"
  post 'add_friend', to: "users#add_friend"


  resources :users do
    resources :comments, only: [:new, :create, :index]
    resources :profile, only: [:edit, :update]
    resources :comments, only: [:new, :create]
    
	resources :characters, except: [:index]
	resources :friends
	post 'set_default_character'
	get 'preview'
  end


  resources :comments


  controller :users do
    get 'signup' => :new
    post 'signup' => :create
  end

  controller :sessions do
	get 'login' => :new
    post 'login' => :create
	get 'logout' => :destroy
  end

  root to: 'comments#new'

end
