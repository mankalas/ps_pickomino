Rails.application.routes.draw do
  resources :users
  resources :games

  root 'welcome#index'
end
