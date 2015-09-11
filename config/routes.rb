Rails.application.routes.draw do
  root 'homes#show'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :session, only: [:new, :create, :destroy]
      resources :users, only: [:new, :create] do
        collection do
          get 'me'
        end
      end
    end
  end
end
