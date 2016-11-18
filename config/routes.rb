Rails.application.routes.draw do
  get 'logout', to: 'sessions#destroy', as: :logout
  root to: 'pages#home'

  resources :exchanges, except: [:index, :destroy], path: '/' do
    resources :participants, only: [:create, :update] do
      get 'retrieve/:login_token', to: 'sessions#create', as: :retrieve
    end
  end
end
