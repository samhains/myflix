Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'video#index'

  resources :video
  resources :category, only: [:show]

end
