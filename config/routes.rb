Rails.application.routes.draw do
  get 'webhook/kokodayo'
  resources :password_resets, only: [:new, :create, :edit, :update]
  # get 'drug_confirmations/index'
  # get 'drug_confirmations/show'
  # get 'drug_confirmations/new'
  # get 'drug_confirmations/edit'
  root 'static_pages#top'
  # root 'medication_checks#index'
  resources :drugs 
  resources :medication_checks
  
  resources :users, only: %i[new create]
  resources :tops
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :drug_confirmations, only: [:index, :show, :edit, :update] do
    member do
      get ':date', action: :show, as: 'with_date_show'
      get 'edit/:date', action: :edit, as: 'with_date_edit'
    end
  end
  # resources :calendars
  resources :calendar_drugs, only: [:index, :show, :new] do
    member do
      get ':date', action: :new, as: 'with_date'
    end
  end
  resources :calendars, only: [:index, :show, :new] do
    member do
      get ':date', action: :show, as: 'with_date'
    end
  end
  
  resource :profile,only: %i[show edit update]
  # root "tops#index"
  # get 'tops/:id' => 'tops#new'
  # get 'tops/:id' => 'tops#edit'
  get 'login', to: 'user_sessions#new' 
  post 'login', to: 'user_sessions#create'
  post '/guest_login', to: 'user_sessions#guest_login'
  delete 'logout', to: 'user_sessions#destroy'

  get '/terms_of_service', to: 'static_pages#terms_of_service'
  get '/privacy_policy', to: 'static_pages#privacy_policy'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Defines the root path route ("/")
  # root "articles#index"
  post '/callback' => 'webhook#callback'
end
