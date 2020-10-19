Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#index'
  resources :tasks do
    put '/update_status', to: 'tasks#update_status'
  end
  resources :tenants
  resources :partners
  resources :houses do
    resources :flats
  end
end
