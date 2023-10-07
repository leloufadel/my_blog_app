Rails.application.routes.draw do
  resources :users do
    resources :posts do
      resources :comments
      member do
        post 'like'
        delete 'unlike'
      end
    end
  end

  resources :likes, only: %i[create destroy]
end