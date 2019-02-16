Rails.application.routes.draw do
  
  devise_for :users
  root to: 'page#index'

  scope :admin do
    resources :users
  end
  resources :wares
end
