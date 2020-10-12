Rails.application.routes.draw do
  devise_for :users
  root_to 'tasks#index'
  resources :tasks
end
