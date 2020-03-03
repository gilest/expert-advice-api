Rails.application.routes.draw do
  use_doorkeeper

   namespace :api do
    namespace :v1 do
      get '/users/me', to: 'users#me'
      resources :users
      resources :questions do
        patch :record_view, on: :collection
      end
      resources :answers, only: :create
    end
  end
end
