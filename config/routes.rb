Rails.application.routes.draw do
  root "products#index"
  get "/products/cart", to: "sessions#cart_view", as: "cart"

  get "/auth/:provider/callback", to: "sessions#create", as: "login"
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  get "/orders/search", to: "orders#search", as: 'search_orders'
  resources :orders

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  post "/products/:id/add_to_cart", to: "sessions#add_to_cart", as: "add_to_cart"
  patch "/products/:id/update_cart", to: "sessions#update_quantity", as: "update_cart"
  get "/products/:id/remove", to: "sessions#remove_from_cart", as: "remove_from_cart"

  resources :users, except: [:edit, :delete]

  resources :categories

  patch "/fulfillment", to:"orderproducts#update", as: "orderproduct"

  get "/fulfillment", to: "orders#fulfillment", as: "get_orders"
  get "/fulfillment/paid", to: "orders#paid", as: "paid_orders"
  get "/fulfillment/completed", to: "orders#completed", as: "completed_orders"
  get "/fulfillment/cancelled", to: "orders#cancelled", as: "cancelled_orders"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
