class Game < ApplicationRecord
  # Association
  has_many :players
  has_many :turns
  has_many :users, through: :players
  has_many :in_game_dominos

  # Validation
  validates :players, presence: { :message => "At least one player is required" }

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
