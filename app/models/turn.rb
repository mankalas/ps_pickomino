class Turn < ApplicationRecord
  belongs_to :game
  belongs_to :player
  has_many :rolls
  has_one :in_game_domino

  def last_roll_outcome
    last_roll = rolls.last
    last_roll.outcome unless last_roll.nil?
  end

  def first_roll?
    rolls.empty?
  end

  def worm_score
    player.worm_score
  end

  def pick_domino!(domino)
    self.in_game_domino = domino
    player.in_game_dominos << domino
    save!
  end
end
