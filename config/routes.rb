Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :passwords, only: [:new, :edit, :create, :update]

  root 'sessions#new'
end
