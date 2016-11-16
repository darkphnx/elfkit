Rails.application.routes.draw do
  get 'logout', to: 'sessions#destroy', as: :logout

  #root to: 'pages#index'

  resources :exchanges, path: '/' do
    resources :participants do
      get 'retrieve/:login_token', to: 'sessions#create'
    end
  end
end
