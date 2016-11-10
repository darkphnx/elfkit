Rails.application.routes.draw do
  get 'retreive/:participant/:login_token', to: 'sessions#create', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  root to: 'pages#index'

  resources :exchanges, path: '/' do
    resources :participants
  end
end
