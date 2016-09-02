class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :turns
  has_many :in_game_dominos

  def name
    user.name
  end

  def color
    user.color
  end
end
