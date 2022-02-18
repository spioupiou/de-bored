Rails.application.routes.draw do
  devise_for :users
  root to: 'games#index' # our landing page with selection of games
  resources :instances, only: [:create, :show, :update] do
    resources :rounds, only: [:create, :show] do
      resources :player_inputs, only: [:create]
    end
  end
  resources :players, only: [:create]
end
