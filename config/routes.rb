Rails.application.routes.draw do
  root 'devices#index'

  resources :devices, only: [:index, :show]
end
