Rails.application.routes.draw do
  root 'sales_batches#index'

  resources :sales_batches, only: [:new, :create, :show, :index]
  resources :sales, only: [:show]
end
