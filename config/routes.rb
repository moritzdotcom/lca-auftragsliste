Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#index'
  resources :tasks do
    put '/update_status', to: 'tasks#update_status'
    put '/update_due_date', to: 'tasks#update_due_date'
  end
  resources :tenants
  resources :partners
  resources :houses do
    resources :flats, only: [:index, :new, :create]
  end

  resources :flats, only: [:edit, :update, :destroy]

  get '/houses/edit', to: 'houses#edit_all', as: 'edit_houses'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/settings', to: 'pages#edit_settings', as: 'edit_settings'
  post '/settings', to: 'pages#update_settings'
end
