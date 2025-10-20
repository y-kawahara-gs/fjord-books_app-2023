Rails.application.routes.draw do
  get 'users/index'
  devise_for :users, controllers: { registratons: 'users/registrations' }
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
