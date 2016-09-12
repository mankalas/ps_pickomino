Rails.application.routes.draw do
  resources :users
  resources :games

  match 'games/:id/roll_dice' => 'games#roll_dice', as: :game_roll_dice, via: :post
  match 'games/:id/pick_dice' => 'games#pick_dice', as: :game_pick_dice, via: :post
  match 'games/:id/pick_domino' => 'games#pick_domino', as: :game_pick_domino, via: :post

  root 'welcome#index'
end
