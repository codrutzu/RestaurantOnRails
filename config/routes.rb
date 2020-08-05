Rails.application.routes.draw do
  root 'home_page#index'
  resources :products, only: %i[index new create show]
end
