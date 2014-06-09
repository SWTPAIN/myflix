Myflix::Application.routes.draw do
  root to: 'pages#front'

  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy' 
  get '/home', to: 'videos#index'
  get '/my_queue', to: 'queue_items#index'
  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:show] do
    collection do
      get 'search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories, only: [:show]
  resources :users, only: [:create]
  resources :queue_items, only: [:create, :destroy] do
    collection do
      patch 'update_multiple'
    end
  end
end
