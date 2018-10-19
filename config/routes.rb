Rails.application.routes.draw do
  get 'orders/new'
  get 'orders/create'
  get 'orders/edit'
  get 'orders/update'

  root "products#index"
  
  get "/auth/:provider/callback", to: "sessions#create"
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'


  resources :orders

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  resources :users, except: [:edit, :delete]

  resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
