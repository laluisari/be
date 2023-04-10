Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", :as => "rails_admin"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  #confirm email
  get '/confirm/:id', to: 'users#confirm_email'

  # root "articles#index"
  resources :db_connection
  resources :notifications
  resources :users
  resources :orders
  resources :cards


  post '/register', to: 'users#create'
  post '/login', to: 'users#login'
  get "db", to: "db_connection#db"
  get "/auth/current_user", to: "users#active_user"
end
