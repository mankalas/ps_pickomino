Rails.application.routes.draw do
  resources :users
  resources :games

  match 'games/:id/roll' => 'games#roll', as: :game_roll, via: :post

  root 'welcome#index'
end
