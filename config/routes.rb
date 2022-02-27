Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home' # our landing page with the animation
  resources :games, only: [:index]
  resources :users, only: [:update]
  get '/qr_code', to: 'players#qr_code'
  resources :instances, only: [:create, :show, :update] do
    resources :rounds, only: [:create, :show] do
      resources :player_inputs, only: [:create]
    end
  end
  resources :players, only: [:create]
end
