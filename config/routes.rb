Rails.application.routes.draw do
  root to: "sessions#new"
  resources :users do
    get 'activate'
    post 'admin'
  end
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: :new
  end
  
  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
    resources :tracks, only: :new
  end
  
  resources :tracks, only: [:create, :edit, :show, :update, :destroy] do
    resources :notes, only: :create
  end
  resources :notes, only: :destroy
end
