Rails.application.routes.draw do

  root to: 'bookmarks#index'
  resources :users, only: [:create, :show, :edit, :update]
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  resources :sessions, only: [:create]
  resources :bookmarks


end
