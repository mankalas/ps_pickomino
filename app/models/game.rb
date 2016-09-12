class Game < ApplicationRecord
  # Association
  has_many :players
  has_many :turns
  has_many :users, through: :players
  has_many :in_game_dominos

  def current_turn
    turns.order(:created_at => :desc).first
  end

  def dominos
    in_game_dominos.where(player: nil)
  end

  def over?
    dominos.empty?
  end
end
