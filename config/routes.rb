Rails.application.routes.draw do
  root 'sessions#new'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :passwords, only: [:new, :edit, :create, :update]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
