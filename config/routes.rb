Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create] do
    get 'activate', on: :collection
  end

  resource :session, only: [:new, :create, :destroy]

  resources :bands, except: :show

  resources :bands, only: [:show] do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :update, :destroy]

  resources :albums, only: [:show] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:create, :edit, :update, :show, :destroy]

  resources :notes, only: [:create, :destroy]

  resources :search, only: [:index]

  root 'sessions#new'
end
