Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'authenticate', to: 'authentication#authenticate'

  resources :trips
  resources :registrations, only: :create
  # resources :confirmations, only: :create
  get 'confirmations', to: 'confirmations#confirm'
  resources :dashboards, only: :index
end
