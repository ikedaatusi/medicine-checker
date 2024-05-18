Rails.application.routes.draw do
  resources :drugs 
  resources :users, only: %i[new create]
  get 'tops/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  resources :calendars

  root "tops#index"
  get 'login', to: 'user_sessions#new' 
  post 'login', to: 'user_sessions#create' 
  delete 'logout', to: 'user_sessions#destroy'

  
  # Defines the root path route ("/")
  # root "articles#index"
end
