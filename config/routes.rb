Rails.application.routes.draw do
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  devise_for :users
  root 'users#index'

  resources :posts, only: [:destroy]
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:new, :create]
    end
  end

  
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end
