Rails.application.routes.draw do
  devise_for :users
  root to: 'games#index' # our landing page with selection of games
  resources :instances, only: [:create, :show, :update] do
    resources :player_inputs, only: [:create, :index]
    collection do
      post :join # to join the instance via pin
    end
  end
end
