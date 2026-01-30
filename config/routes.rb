Rails.application.routes.draw do
  resource :session
  resource :profile, only: :show

  resources :books do
    collection do
      get :search_cover
      get :proxy_image
      post :apply_cover
    end
  end

  resources :passwords, param: :token
  resources :loans
  resources :users
  resources :book_copies

  root "home#index"
  get "/home", to: "home#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
