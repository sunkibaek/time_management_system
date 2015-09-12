Rails.application.routes.draw do
  root 'homes#show'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :session, only: [:create, :destroy]
      resources :tasks, only: [:index, :create]
      resources :users, only: [:create] do
        collection do
          get 'me'
        end
      end
    end
  end
end
