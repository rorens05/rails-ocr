Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :mobile_releases
  resources :notifications
  resources :players
  resources :game_records
  mount ActionCable.server => '/cable'

  
  resources :users, path: 'user' do
    member do
      patch :toggle_verification
    end
  end

  get 'profile', to: 'profile#index'
  get 'profile/change_password'
  patch 'profile/update_password'
  devise_for :users
  get 'users/:id' => 'users#show'
  get 'home/index'
  root 'home#index'

  get 'confirm_email/:token', to: 'email_handler#confirm_email'

  namespace :api do
    namespace :v2 do
      post 'ocr/index'
      get 'auth/connection_test'
      post 'auth/login'
      post 'auth/login_with_facebook'
      post 'auth/login_with_google'
      post 'auth/login_with_apple'
      get 'auth/profile'
      delete 'auth/logout'
      post 'auth/register'
      post 'auth/resend_confirmation_email'
      post 'auth/forgot_password'
      post 'auth/resend_forgot_password_code'
      post 'auth/verify_forgot_password_code'
      post 'auth/change_password'
      patch 'profile/update_profile'
      get 'latest_version' => 'version_checker#latest_version'
      
      resources :notifications, only: [:index]

      resources :locations do 
        collection do
          get :regions
          get :provinces
          get :cities
        end
      end
      resources :networks, only: [:index]
      resources :roulettes, only: [:index, :show] do
        member do 
          post :spin_game
        end
        collection do
          get :my_prices
        end
      end
    end
  end
end
