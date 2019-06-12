Rails.application.routes.draw do
  root 'tweets#index'
  devise_for :users
  resources :tweets, only: [:index, :show, :new, :create, :destroy, :edit, :update]do
    resources :comments, only: [:create]
end
  resources :users, only: [:show]
end

