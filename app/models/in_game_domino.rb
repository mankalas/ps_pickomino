class InGameDomino < ApplicationRecord
  belongs_to :game
  belongs_to :player, optional: true
  belongs_to :domino

  def value
    domino.value
  end

  def nb_worms
    domino.nb_worms
  end
end
