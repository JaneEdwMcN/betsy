Rails.application.routes.draw do
  root "products#index"
  
  get "/auth/:provider/callback", to: "sessions#create"
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  resources :orders

  resources :products do
    resources :reviews, only: [:new, :create]
  end
  get "/products/:id/add_to_cart", to: "products#add_to_cart", as: "add_to_cart"

  resources :users, except: [:edit, :delete]

  resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
