Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/my_queue', to: 'queue_items#index'
  root to: 'pages#front'
  resources :videos do
    collection do
      get 'search'
    end
    member do
      resources :reviews, only: [:create]
    end
  end
  resources :categories, only: [:show]
  resources :users, except: [:destroy,:new] 
  resources :queue_items, except: [:new, :show, :index]
end
