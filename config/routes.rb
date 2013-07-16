Tweek::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      resource :user, only: [:create, :update, :destroy]
      resources :movies, only: [:create, :update, :destroy] do
        resource :like, only: [:create, :destroy]
      end

    end
  end

end
