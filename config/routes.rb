Rails.application.routes.draw do
  get 'logout', to: 'sessions#destroy', as: :logout

  resources :exchanges, path: '/' do
    resources :participants do
      get 'retrieve/:login_token', to: 'sessions#create', as: :retrieve
    end
  end
end
