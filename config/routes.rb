# Rails.application.routes.draw do
#   get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
#   devise_for :users
#   root 'users#index'
  
#     resources :posts, only: %i[destroy] 
  

#   resources :users, only: %i[index show] do
#     resources :posts, only: %i[index show new create] do
#       resources :comments, only: %i[new create destroy]
#       resources :likes, only: %i[new create]
#     end
#   end
# end
# Rails.application.routes.draw do
#   # Web application routes
#   resources :users do
#     resources :posts
#   end

#   # API routes
#   namespace :api, defaults: { format: 'json' } do
#     resources :users, only: [:index]
    
#     resources :posts, only: [] do
#       resources :comments, only: [:index, :create]
#     end
#   end
# end

Rails.application.routes.draw do
  # Your existing routes for the web application
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  devise_for :users
  root 'users#index'
  resources :posts, only: %i[destroy] 
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[new create]
    end
  end

  # API routes
  namespace :api, defaults: { format: 'json' } do
    resources :users, only: [:index] do
      resources :posts, only: [:index]
    end
    
    resources :posts, only: [] do
      resources :comments, only: [:index, :create]
    end
  end
end