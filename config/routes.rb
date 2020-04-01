Rails.application.routes.draw do
  	root 'homes#top'
	devise_for :users, controllers: {
	  sessions: 'users/sessions',
	  registrations: 'users/registrations'
	}
	resources :homes, only:[:new,:create]
	resources :users
	resources :tweets do
		resource :comments, only: [:create, :destroy]
    	resource :favorites, only: [:create, :destroy]
    end
    resources :messages, :only => [:create]
    resources :rooms, :only => [:create, :show, :index]
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
	get 'users/following/:user_id' => 'users#following', as:'users_following'
	get 'users/follower/:user_id' => 'users#follower', as:'users_follower'
    get 'search' => 'users#search'
    get 'favorite/:user_id' => 'favorites#index',as:'favorite'
end