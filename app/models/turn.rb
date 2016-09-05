class Turn < ApplicationRecord
  belongs_to :game
  belongs_to :player
  has_many :rolls
  has_one :in_game_domino
end
