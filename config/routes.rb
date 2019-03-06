Rails.application.routes.draw do
  
  resources :dues
  resources :payments, only: [:create, :update, :destroy]
  resources :orders do
    resources :payments
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

      resources :payments, only: :index
      resources :orders do
        resources :payments, only: :create
      end
      resources :wares, only: :index
      resources :departments, only: :index do
        get :cities
      end
      get 'coordinates', to: 'orders#coordinates'
    end
  end
end
