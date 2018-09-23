Rails.application.routes.draw do
  
  root to: "homepage#index"
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, except: [:new] do
    member do
      get :likes
      get :followings
      get :followers
    end
  end
  
  resources :artworks
  resources :follows, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end
