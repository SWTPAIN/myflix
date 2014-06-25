require 'sidekiq/web'
Myflix::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: 'pages#front'


  get '/register', to: 'users#new'
  get '/register/:token', to: 'users#new_with_invitation_token',
    as: 'register_with_token'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy' 
  get '/home', to: 'videos#index'
  get '/my_queue', to: 'queue_items#index'
  get '/people', to: 'relationships#index'
  get 'ui(/:action)', controller: 'ui'
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  get 'expired_token', to: 'pages#expired_token'
  get 'invite', to: 'invitations#new'

  resources :videos, only: [:show] do
    collection do
      get 'search'
    end
    resources :reviews, only: [:create]
  end
  resources :relationships, only: [:destroy, :create]
  resources :categories, only: [:show]
  resources :users, only: [:create, :show]
  resources :queue_items, only: [:create, :destroy] do
    collection do
      patch 'update_multiple'
    end
  end
  resources :forgot_passwords, only: [:create]
  resources :reset_passwords, only: [:show, :create]
  resources :invitations, only:[:create]

  namespace :admin do
    resources :payments, only: [:index]
    resources :videos, only:[:new, :create]
  end

  resources :payments, only: [:create]
  mount StripeEvent::Engine => '/stripe_events'
end
