Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_closed', on: :member
  end
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'

  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'

  root 'breweries#index'

  post 'close/:id', to: 'users#close'
end
