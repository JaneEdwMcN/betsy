Rails.application.routes.draw do
  root "products#index"
  get "/products/cart", to: "products#cart_view", as: "cart"

  get "/auth/:provider/callback", to: "sessions#create", as: "login"
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  resources :orders

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  post "/products/:id/add_to_cart", to: "products#add_to_cart", as: "add_to_cart"
  patch "/products/:id/update_cart", to: "products#update_quantity", as: "update_cart"
  get "/products/:id/remove", to: "products#remove_from_cart", as: "remove_from_cart"

  resources :users, except: [:edit, :delete]

  resources :categories

  get "/fulfillment", to: "orders#fulfillment", as: "get_orders"
  get "/fulfillment/paid", to: "orders#paid", as: "paid_orders"
  get "/fulfillment/completed", to: "orders#fulfillment", as: "cancelled_orders"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
