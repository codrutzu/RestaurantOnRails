Rails.application.routes.draw do
  get 'users/new'
  root 'home_page#index'
  get '/signup', to: "users#new"
  resources :products, only: %i[index new create show]
  resources :users, only: %i[new show create]
end
