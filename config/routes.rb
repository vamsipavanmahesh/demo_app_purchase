Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :purchases, only: [:index, :new, :show, :create]

  root to: 'purchases#index'
end
