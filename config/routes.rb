Rails.application.routes.draw do
  devise_for :users
  resources :manufacturers, only: [:index, :show, :new, :create, :edit, :update]
  resources :subsidiaries
  resources :car_categories, only: [:index, :show, :new, :create, :edit, :update]
  resources :clients, only: [:index, :show, :new, :create]
  resources :car_models, only: [:index, :show, :new, :create, :edit, :update]
  root to: 'home#index'
end
