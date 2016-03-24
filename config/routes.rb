Rails.application.routes.draw do
  resources :weather_grid
  get 'welcome/index'
  root to: "welcome#index"
end
