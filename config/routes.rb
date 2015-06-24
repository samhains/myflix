Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  root to: 'sessions#index'
  resources :videos do
    collection do
      post 'search'
    end
  end
  resources :categories, only: [:show]
  resources :users, except: [:destroy,:new] 

end
