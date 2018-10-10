Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  root 'breweries#index'

  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :beers
  resources :breweries
  resource :session, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  get 'places', to: 'places#index'
  post 'places', to:'places#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
