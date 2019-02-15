Rails.application.routes.draw do
  devise_for :users
  root to: 'page#index'

  resources :users
end
