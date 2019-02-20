Rails.application.routes.draw do
  
  resources :inventory_transfers
  resources :load_wares
  devise_for :users
  root to: 'page#index'

  scope :admin do
    resources :users
  end
  resources :wares

  post 'auth/login', to: 'authentication#authenticate'
  get 'validate/token', to: 'authentication#validate_token'

end
