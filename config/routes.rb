Rails.application.routes.draw do
  devise_for :users

  resources :landings, only: [:index]

  resources :categories, path: 'categories' do
    resources :bills, path: 'bills', as: 'category_bills', only: [:new, :create]
  end

  root "landings#index"
end
