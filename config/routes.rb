Rails.application.routes.draw do
  
  resources :payments
  resources :orders do
    get 'payments'
  end
  resources :inventory_transfers
  resources :load_wares
  resources :orders_wares
  devise_for :users
  root to: 'page#index'

  scope :admin do
    resources :users
  end
  resources :wares

  post 'auth/login', to: 'authentication#authenticate'
  get 'validate/token', to: 'authentication#validate_token'

  
  scope module: :v1, constraints: ApiVersion.new('v1') do
    scope :api do
      resources :payments
      resources :orders
      get 'coordinates', to: 'orders#coordinates'
    end
  end
end
