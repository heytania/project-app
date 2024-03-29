Rails.application.routes.draw do
  get 'about', to: 'static_pages#about'
   
  resources :articles, only: [:show]
  resources :authors, only: [:show]
  resources :countries, only: [:show]
  
  root 'static_pages#home'
end
