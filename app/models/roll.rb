class Roll < ApplicationRecord
  belongs_to :turn

  def score
    pick_value * nb_dice_picked
  end

  def nb_dice_picked
    (outcome.nil? || pick.nil?) ? 0 : outcome.count(pick)
  end

  private

  def pick_value
    pick == 'W' ? 5 : (pick.nil? ? 0 : pick.to_i)
  end
end
