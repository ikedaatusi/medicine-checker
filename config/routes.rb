Rails.application.routes.draw do
  get 'tops/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "tops#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
