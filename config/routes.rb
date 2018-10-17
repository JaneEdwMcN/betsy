Rails.application.routes.draw do
  resources :orders

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  resources :users, except: [:edit, :delete]

  resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
