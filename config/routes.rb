Rails.application.routes.draw do
  root 'pages#home'

  get 'home' => 'pages#home', as: :home
  get 'search' => 'pages#search', as: :search
  # get 'search_result' => 'pages#search_result', as: :search_result
  get 'show_device' => 'pages#show_device', as: :show_device
end
