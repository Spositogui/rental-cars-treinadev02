Rails.application.routes.draw do
  resources :manufacturers, only: [:index, :show, :new, :create]
  resources :subsidiaries, only: [:index, :show]
  root to: 'home#index'
end
