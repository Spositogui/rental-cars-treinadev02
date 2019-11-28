Rails.application.routes.draw do
  resources :manufacturers
  root to: 'home#index'
end
