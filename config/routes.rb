Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :books do
    resources :comments, only: [:create, :destroy]
  end

  resources :reports do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: %i(index show)
end
