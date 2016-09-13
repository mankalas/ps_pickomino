Rails.application.routes.draw do
  resources :users
  resources :games, only: [:show, :new, :create, :destroy]

  match 'games/:id/roll_dice' => 'games#roll_dice', as: :game_roll_dice, via: :post
  match 'games/:id/pick_dice' => 'games#pick_dice', as: :game_pick_dice, via: :post
  match 'games/:id/pick_domino' => 'games#pick_domino', as: :game_pick_domino, via: :post
  match 'games/:id/pass' => 'games#pass', as: :game_pass, via: :post

  root 'welcome#index'
end
