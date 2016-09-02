class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def name
    user.name
  end

  def color
    user.color
  end
end
