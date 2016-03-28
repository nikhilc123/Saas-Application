Rails.application.routes.draw do
  devise_for :users
  resources :weather_grid
  resources :subscriptions
  get 'welcome/index'
  root to: "welcome#index"
end
