Rails.application.routes.draw do
  resources :exchanges, path: '/' do
    resources :participants
  end
end
