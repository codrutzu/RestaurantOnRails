Rails.application.routes.draw do
  root 'home_page#index'

  # Home page
  get 'home', to: 'home_page#index'

  # Password reset
  get 'password_resets/new'
  get 'password_resets/edit'

  # Session
  get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Cart products
  post 'add_product', to: 'cart_products#create'
  delete 'delete_product', to: 'cart_products#destroy'

  # Cart
  get '/cart', to: 'carts#show'

  # User
  get '/signup', to: 'users#new'

  # Admin
  get '/admin', to: 'admin#index'

  # Order products
  get 'order_products/index'

  resources :users, only: %i[create new show edit]
  resources :carts, only: %i[show]
  resources :account_activations, only: :edit
  resources :password_resets, only: %i[new create edit update]
  resources :orders, only: %i[new create show]
  resources :order_products, only: :index

  namespace :admin do
    resources :users, only: %i[index destroy]
    resources :products, only: %i[new create show]
    resources :orders, only: %i[index destroy]
  end
end
