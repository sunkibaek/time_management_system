Rails.application.routes.draw do
  root 'homes#show'

  %w(/log_in /sign_up /tasks /tasks/new /tasks/edit/:id /settings).each do |path|
    get path, to: 'homes#show'
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :session, only: [:create, :destroy]
      resources :tasks, only: [:index, :create, :update, :show, :destroy]
      resources :users, only: [:create] do
        collection do
          get 'me'
        end
      end
    end
  end
end
