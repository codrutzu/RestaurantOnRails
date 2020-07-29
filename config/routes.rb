Rails.application.routes.draw do
  resources :products
  get "home_page/index"
  get 'products/new'
  get 'products/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home_page#index'
end
