Rails.application.routes.draw do
  root to: 'page#index'
  get 'page/index'
end
