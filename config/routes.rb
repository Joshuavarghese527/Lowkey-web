Rails.application.routes.draw do


devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
root to: 'location#index'

 devise_for :users,
             path: '',
             path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
             controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  resources :users, only: [:show] do
    member do
      post '/verify_phone_number' => 'users#verify_phone_number'
      patch '/update_phone_number' => 'users#update_phone_number'
    end
  end

  resources :location do
    member do
    get 'preload'
    get 'preview'
  end
    resources :reviews, only: [:create, :destroy]
    resources :reservations, only: [:create]
    resources :photos, only: [:create, :destroy]
  end

  get '/your_trips' => 'reservations#your_trips'
  get 'search' => 'location#search'

  # --------- DashBoard --------
  get 'dashboard' => 'dashboards#index'

  resources :reservations, only: [:approve, :decline] do
    member do 
      post '/approve' => "reservations#approve"
      post '/decline' => "reservations#decline"
    end
  end

  get '/payment_method' => 'users#payment'
  post '/add_card' => "users#add_card"
end
