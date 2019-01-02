Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'registrations#create'


  # root 'dashboard#index'
  get '/dashboard', to: 'dashboard#index'

        namespace :admin do
    resources :users
  end
end