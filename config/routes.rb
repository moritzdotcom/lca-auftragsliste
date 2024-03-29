Rails.application.routes.draw do
  root to: 'pages#landing'

  get '/product', to: 'marketing#product', as: 'marketing_product'
  get '/about', to: 'marketing#about', as: 'marketing_about'
  get '/contact', to: 'marketing#contact', as: 'marketing_contact'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show] do
    member do
      get '/edit_profile', to: 'users#edit_profile'
      patch '/update_profile', to: 'users#update_profile'
    end
  end

  resources :tenants
  resources :partners
  resources :companies

  resources :tasks do
    get '/new_email', to: 'tasks#new_email'

    resources :create_task
  end


  get '/calendar', to: 'tasks#calendar'

  get '/houses/edit', to: 'houses#edit_all', as: 'edit_houses'

  resources :houses do
    resources :flats, only: [:index, :new, :create]
  end

  resources :flats, only: [:edit, :update, :destroy]

  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/settings', to: 'pages#edit_settings', as: 'edit_settings'
  post '/settings', to: 'pages#update_settings'
  get '/mail_log', to: 'pages#mail_log'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users
    end
  end
end
