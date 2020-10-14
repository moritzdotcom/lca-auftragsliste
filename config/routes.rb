Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#index'
  resources :tasks
  resources :tenants
  resources :partners
  resources :houses do
    resources :flats
  end
end
