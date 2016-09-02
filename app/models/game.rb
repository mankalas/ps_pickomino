class Game < ApplicationRecord
  # Association
  has_many :players
  has_many :users, through: :players
  has_many :in_game_dominos
end
