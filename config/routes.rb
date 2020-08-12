Rails.application.routes.draw do
  root 'home_page#index'
  get 'products/show'
  get 'sessions/new'
  get 'users/new'
  post 'add_product/:id', to: 'add_to_cart#add_product_to_cart'
  get '/cart', to: 'carts#show'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :products, only: %i[index new create show]
  resources :users, only: %i[new show create]
  resources :carts, only: %i[show]
end
