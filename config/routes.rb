Rails.application.routes.draw do
  # Users routes
  resources :users, only: [ :create, :update, :show, :destroy ]

  # Sessions routes
  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"
end
