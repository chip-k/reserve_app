Rails.application.routes.draw do
  
  root :to => 'homes#index'
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  
  devise_for :admins, controllers: {
   sessions: "admins/sessions"
  }
  namespace :admins do
   resources :users, only: %i(index destroy edit update)
  end
  
  get 'reservations/days' => 'reservations#days'
  resources :reservations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
