Rails.application.routes.draw do
  devise_for :users
  resources :weather_grid
  get 'welcome/index'
  root to: "welcome#index"
end
