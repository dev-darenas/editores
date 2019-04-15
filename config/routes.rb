Rails.application.routes.draw do
  
  resources :enterprises
  resources :activities
  resources :dues
  resources :payments, only: [:create, :update, :destroy]
  resources :orders do
    resources :payments
    collection do
      get :transfer
    end
  end

  resources :reports do
    collection do
      get :collection
    end
  end

  resources :inventory_transfers
  resources :load_wares
  resources :countries
  resources :departments
  resources :cities
  resources :orders_wares
  devise_for :users
  root to: 'dashboard#index'

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
      resources :countries, only: :index
      resources :enterprises, only: :index
      resources :dashboard, only: :index
      resources :dues, only: :index
      get 'coordinates', to: 'orders#coordinates'
      get 'search', to: 'orders#search'
    end
  end
end
