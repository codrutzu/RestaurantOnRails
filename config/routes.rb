Rails.application.routes.draw do
  root 'home_page#index'
  get 'sessions/new'
  post 'add_product/:id', to: 'add_to_cart#add_product_to_cart'
  get '/cart', to: 'carts#show'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :products, only: %i[index new create show]
  resources :carts, only: %i[show]
end
