class InGameDomino < ApplicationRecord
  belongs_to :game
  belongs_to :player, optional: true
  belongs_to :domino

  def value
    domino.value
  end
end
