Rails.application.routes.draw do
  root 'static_pages#top'
  resources :already_taken
  resources :currently_taking
  resources :password_resets, only: [:new, :create, :edit, :update]
  # root 'medication_checks#index'
  resources :drugs 
  resources :medication_checks
  resources :users, only: %i[new create]
  resources :tops
  resource :profile,only: %i[show edit update]
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
  resources :calendars, only: [:index, :show, :new, :edit, :update, :create] do
    member do
      get ':date', action: :show, as: 'with_date_show'
      get 'edit/:date', action: :edit, as: 'with_date_edit'
      patch ':date', action: :update, as: 'with_date_update'
    end
  end

  get 'login', to: 'user_sessions#new' 
  post 'login', to: 'user_sessions#create'
  post '/guest_login', to: 'user_sessions#guest_login'
  delete 'logout', to: 'user_sessions#destroy'

  get '/terms_of_service', to: 'static_pages#terms_of_service'
  get '/privacy_policy', to: 'static_pages#privacy_policy'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Defines the root path route ("/")
  post '/callback' => 'webhook#callback'
end
