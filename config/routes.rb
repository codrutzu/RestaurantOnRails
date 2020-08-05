Rails.application.routes.draw do
  root 'home_page#index'
  get 'sessions/new'
  get 'users/new'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :products, only: %i[index new create show]
  resources :users, only: %i[new show create]
end
