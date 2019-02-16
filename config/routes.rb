Rails.application.routes.draw do
  resources :wares
  devise_for :users
  root to: 'page#index'

  scope :admin do
  	resources :users	
  end
  
end
