Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home' # our landing page with the animation
  resources :games, only: [:index]
  resources :users, only: [:update]
  get '/join_instance', to: 'players#join_instance'
  resources :instances, only: [:create, :show, :update] do
    member do
      get '/edit_nickname', to: 'players#edit_nickname'
      get '/create_players', to: 'players#create_players'
    end
    resources :rounds, only: [:create, :show] do
      resources :player_inputs, only: [:create]
    end
  end
end
