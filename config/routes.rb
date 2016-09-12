Rails.application.routes.draw do
  resources :users
  resources :games

  match 'games/:id/progress' => 'games#progress', as: :game_progress, via: :post

  root 'welcome#index'
end
