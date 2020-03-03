Rails.application.routes.draw do
  use_doorkeeper

   namespace :api do
    namespace :v1 do
      get '/users/me', to: 'users#me'
      resources :users
      resources :questions, only: [:index, :show, :create]
      resources :answers, only: :create
    end
  end
end
