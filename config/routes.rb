Rails.application.routes.draw do
  
  root :to => 'homes#index'
  
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations',
  }
  
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    registrations: 'admins/registrations',
  }
  
  devise_for :temples, controllers: {
    sessions:      'temples/sessions',
    registrations: 'temples/registrations',
  }
  
  namespace :admins do
    resources   :users, only: %i(index show destroy edit update) do
      get 'reservations', on: :member
      get 'reservation',  on: :member
    end
    resources :temples, only: %i(index show destroy edit update)
  end
  
  resources :reservations, only: %i(index show destroy update) do
    get 'complete', on: :member
  end
  
  namespace :temples do
    resources :users, only: %i(index show) do
      resources :reservations, only: %i(show index destroy)
    end
    resources :reservations,  only: %i(new create edit update) do
      patch :delete_user,     on:   :member
      patch 'update_status',  to:   'reservations#update_status', as: 'update_status'
      get   'all',            on:   :collection
    end
    get     'reservations/month'   =>  'reservations#month'
    get     'reservations/week'    =>  'reservations#week'
    get     'reservations_by_day', to: 'reservations#reservations_by_day', as: 'reservations_by_day'
    delete  'reservations_by_day', to: 'reservations#destroy_by_day',      as: 'destroy_reservations_by_day'
  end
  
  resources :temples, only: [:index, :show] do
    get 'management', to: :collection
  end
  
  post  '/temples/:id/assign_temple', to: 'users#assign_temple',   as: 'assign_temple'
  patch '/users/unassign_temple',     to: 'users#unassign_temple', as: 'unassign_temple'
  
  resources :articles
  resources :posts
  resources :users,  only: [:show]
  resources :admins, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
