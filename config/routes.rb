Rails.application.routes.draw do
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new' 
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get '/terms_of_service', to: 'static_pages#terms_of_service'
  get '/privacy_policy', to: 'static_pages#privacy_policy'
  resources :drug_names
  resources :already_taken
  resources :currently_taking
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :drugs
  resources :medication_checks
  resources :users, only: %i[new create]
  resources :tops
  resource :profile,only: %i[show edit update]
  resources :memos, only: [:new, :create, :edit, :update, :destroy] do
    member do
      get ':date/:drug_id', action: :new, as: 'with_date_new'
      post ':date/:drug_id', action: :create, as: 'with_date_create'
      get ':date/:drug_id', action: :show, as: 'with_date_show'
      get 'edit/:date/:drug_id', action: :edit, as: 'with_date_edit'
      patch ':date/:drug_id', action: :update, as: 'with_date_update'
      delete '', action: :destroy, as: 'with_date_delete'
    end
  end
  resources :drug_confirmations, only: [:index, :show, :edit, :update] do
    member do
      get ':date', action: :show, as: 'with_date_show'
      get 'edit/:date', action: :edit, as: 'with_date_edit'
    end
  end
  resources :calendar_drugs, only: [:index, :show, :new] do
    member do
      get ':date', action: :new, as: 'with_date'
    end
  end
  resources :calendars, only: [:index, :show, :new, :edit, :update, :create] do
    member do
      get ':date/:drug_id', action: :new, as: 'with_date_new'
      post ':date/:drug_id', action: :create, as: 'with_date_create'
      get ':date', action: :show, as: 'with_date_show'
      get ':date/edit/:drug_id', action: :edit, as: 'with_date_edit'
      patch ':date', action: :update, as: 'with_date_update'
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  post '/callback' => 'webhook#callback'
end
