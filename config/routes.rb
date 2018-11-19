Rails.application.routes.draw do
  post 'slackbot', to: 'slackbot#event'

  get 'logout', to: 'sessions#destroy', as: :logout
  root to: 'pages#home'

  resources :exchanges, except: [:index], path: '/' do
    resources :participants, only: [:create, :update, :destroy] do
      get 'retrieve/:login_token', to: 'sessions#create', as: :retrieve
    end
  end
end
