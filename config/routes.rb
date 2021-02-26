Rails.application.routes.draw do
  root 'redesign#index'

  # Home page
  get '/home', to: 'redesign#index'

  # Old design
  get '/old_design', to: 'home_page#index'

  # Password reset
  get 'password_resets/new'
  get 'password_resets/edit'

  # Session
  get 'sessions/new'
  # get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  # Cart products
  post 'add_product', to: 'cart_products#create'
  delete 'delete_product', to: 'cart_products#destroy'

  # Cart
  get '/cart', to: 'redesign#index'

  # User

  # Admin
  get '/admin', to: 'admin#index'

  # Order products
  get 'order_products/index'

  # resources :users, only: %i[create new show edit update]
  # resources :carts, only: %i[show]
  # resources :account_activations, only: :edit
  # resources :password_resets, only: %i[new create edit update]
  # resources :orders, only: %i[new create]
  # resources :order_products, only: :index

  namespace :admin do
    resources :users, only: %i[index destroy]
    resources :products, only: %i[new create show]
    resources :orders, only: %i[index update]
  end

  get 'orders/:id', to: 'redesign#index'
  get '/login', to: 'redesign#index'
  get '/register', to: 'redesign#index'

  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index]
      resources :users, only: %i[show create] do
        get '/current_user', action: :show, on: :collection
      end

      resources :cart_products, only: %i[create]

      resources :orders, only: %i[show create]

      resources :sessions, only: %i[create destroy] do
        delete '/', action: :destroy, on: :collection
      end
    end
  end
end
