Rails.application.routes.draw do
  devise_for :users
 
 
  resources :landings, only: [:index]
  resources :categories do
    resources :bills
  end
  root "landings#index"
end
