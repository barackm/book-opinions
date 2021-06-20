Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "opinions#index"
  resources :users
  resources :opinions do 
    resources :votes, only: [:create, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :comments, only: [:create]
  resources :followings, only: [:create, :destroy]
end
