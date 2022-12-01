Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#homepage'

  get 'homepage', to: 'home#homepage'
  get 'dashboard', to: 'home#dashboard'

  get 'exports', to: 'exports#exports'
  post 'exports', to: 'exports#exports'
  
end
