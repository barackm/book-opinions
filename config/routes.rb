Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "opinions#index"
  resources :users
  resources :opinions
  resources :sessions, only: [:new, :create, :destroy]
end
