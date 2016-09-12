class Turn < ApplicationRecord
  belongs_to :game
  belongs_to :player
  has_many :rolls
  has_one :in_game_domino

  scope :most_recent_first, -> { order(:created_at => :desc) }

  def self.most_recent
    most_recent_first.first
  end

  def dice_score
    rolls.sum(&:score)
  end

  def lost?
    rolls.present? && !available_dice_values
  end

  def last_roll_outcome
    rolls.last.outcome if rolls.present?
  end

  def available_dice_values
    if rolls.present?
      picked_values = rolls.collect { |roll| roll.pick }
      rolled_values = last_roll_outcome.chars.uniq
      (rolled_values - picked_values).sort
    end
  end

  def can_pick_dice?
    rolls.present? && !lost?
  end

  def can_pick_domino?
    rolls.present? && rolls.last.pick.nil?
  end
end
