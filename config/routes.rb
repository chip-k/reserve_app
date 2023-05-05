Rails.application.routes.draw do
  
  root :to => 'homes#index'
  
  devise_scope :user do
    get '/users/sign_out' => 'users/sessions#destroy'
  end
  
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'customers/passwords',
    registrations: 'users/registrations',
  }
  
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations',
  }
  namespace :admins do
   resources :users, only: %i(index destroy edit update)
  end
  
  get 'reservations/days' => 'reservations#days'
  resources :reservations
  
  resources :homes
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
