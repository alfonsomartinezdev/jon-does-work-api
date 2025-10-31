Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  post "/login", to: "auth#login"

  namespace :api do
    namespace :v1 do
      resources :tasks, only: [ :index, :create, :update, :destroy ] do
        resources :work_sessions, only: [ :create, :destroy ]
      end
    end
  end
end
