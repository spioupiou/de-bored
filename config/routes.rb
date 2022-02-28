Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home' # our landing page with the animation
  resources :games, only: [:index]
  resources :users, only: [:update]
  get '/create_players', to: 'players#create_players'
  resources :instances, only: [:create, :show, :update] do
    resources :rounds, only: [:create, :show] do
      resources :player_inputs, only: [:create]
    end
  end
end
