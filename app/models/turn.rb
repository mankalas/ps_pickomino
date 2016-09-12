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

  # You've lost if you have just rolled the dice and there is no value
  # you can pick OR you've just picked the last dice and you can't
  # pick a domino
  def lost?
    rolls.present? &&
      ((rolls.last.pick.nil? && available_dice_values.empty?) ||
       (!any_dice_left? && !can_pick_domino?))
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

  def can_roll?
    (rolls.empty? || rolls.last.outcome.nil? || !rolls.last.pick.nil?) && any_dice_left?
  end

  def first_pick?
    rolls.empty? || (rolls.count == 1 && rolls.last.pick.nil?)
  end

  def can_pick_dice?
    rolls.present? && rolls.last.pick.nil? && !lost? && any_dice_left?
  end

  def can_pick_domino?
    # At least one roll has been made
    rolls.present? &&
      # There are some dominos that can be picked
      !FetchAvailableDominos.new(game).call.empty? &&
      # The player has picked some worm-sided dice
      rolls.any? { |roll| roll.pick? && roll.pick.include?('W') }
  end

  def any_dice_left?
    rolls.sum(&:nb_dice_picked) < 8 #TODO: magic number
  end
end
