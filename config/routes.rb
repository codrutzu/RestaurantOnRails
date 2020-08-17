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

  resources :users, only: %i[create new show edit]
  resources :products, only: %i[index new create show]
  resources :carts, only: %i[show]
  resources :add_to_cart, only: :create
  resources :account_activations, only: :edit
  resources :password_resets, only: %i[new create edit update]

  namespace :admin do
    resources :users, only: %i[index destroy]
  end
end
