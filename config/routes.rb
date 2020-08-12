Rails.application.routes.draw do
  root 'home_page#index'
  get 'sessions/new'
  post 'add_product/:id', to: 'add_to_cart#create'
  get '/cart', to: 'carts#show'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :products, only: %i[index new create show]
  resources :carts, only: %i[show]
  resources :add_to_cart, only: :create
  resources :account_activations, only: :edit
end
