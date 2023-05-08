Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", :as => "rails_admin"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  #confirm email
  get '/confirm/:id', to: 'users#confirm_email'

  # root "articles#index"

  get "/form2", to: "generates#index"
  post "/upload", to: "generates#upload"


  resources :db_connection
  resources :dashboards
  resources :notifications
  resources :user
  resources :user_dashboard
  resources :users
  resources :orders
  resources :cards

  # route for check db connection
  post '/db_connection/db_check', to: 'db_connection#connection_check'

  # root forgot password
  post 'forgot_password', to: 'users#forgot_password'
  get '/reset_password/:token', to: 'password_resets#edit'
  patch '/reset_password/:token', to: 'password_resets#update'
  post '/register', to: 'users#create'
  post '/login', to: 'users#login'
  get 'db', to: 'db_connection#db'
  get '/auth/current_user', to: 'users#active_user'
end
