Rails.application.routes.draw do
  root 'medication_checks#index'
  resources :drugs 
  resources :medication_checks
  
  resources :users, only: %i[new create]
  resources :tops
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # resources :calendars
  resources :calendars, only: [:index, :show] do
    member do
      get ':date', action: :show, as: 'with_date'
    end
  end

  # root "tops#index"
  # get 'tops/:id' => 'tops#new'
  # get 'tops/:id' => 'tops#edit'
  get 'login', to: 'user_sessions#new' 
  post 'login', to: 'user_sessions#create' 
  delete 'logout', to: 'user_sessions#destroy'

  
  # Defines the root path route ("/")
  # root "articles#index"
end
