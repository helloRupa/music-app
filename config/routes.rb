Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy]

  resources :bands

  resources :bands, only: [:show] do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :update, :show, :destroy]

  root 'sessions#new'
end
