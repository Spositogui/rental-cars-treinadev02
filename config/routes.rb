Rails.application.routes.draw do
  resources :manufacturers, only: [:index, :show, :new, :create]
  root to: 'home#index'
end
