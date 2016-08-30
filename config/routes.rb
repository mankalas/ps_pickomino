Rails.application.routes.draw do
  resources :players
  resources :games

  root 'welcome#index'
end
