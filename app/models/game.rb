class Game < ApplicationRecord
  # Association
  has_many :players
  has_many :turns
  has_many :users, through: :players
  has_many :in_game_dominos

  def current_turn
    turns.order(:created_at).last
  end

  def current_turn_rank
    current_turn
  end
end
