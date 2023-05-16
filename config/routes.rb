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
   resources :users, only: %i(index show destroy edit update) do
     resources :reservations, only: %i(show index destroy)
   end
   resources :reservations, only: %i(new edit update destroy)
   get 'reservations_by_day', to: 'reservations#reservations_by_day', as: 'reservations_by_day'
  end
  
  get 'reservations/month' => 'reservations#month'
  get 'reservations/week' => 'reservations#week'
  resources :reservations
  
  resources :homes
  resources :posts
  resources :users, only: [:show]
  resources :admins, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
