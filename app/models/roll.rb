class Roll < ApplicationRecord
  belongs_to :turn

  def score
    if pick
      (pick == 'W' ? 5 : pick.to_i) * outcome.count(pick)
    else
      0
    end
  end
end
