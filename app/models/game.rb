class Game < ApplicationRecord
  # Association
  has_many :players
  has_many :turns
  has_many :users, through: :players
  has_many :in_game_dominos

  def current_turn
    turns.order(:created_at).last
  end

  def current_turn_rank
    current_turn
  end

  def last_roll_outcome
    last_roll = current_turn.rolls.last
    last_roll.outcome unless last_roll.nil?
  end

  def first_roll?
    current_turn.rolls.empty?
  end

  def pick_domino(value)
    domino = in_game_dominos.joins(:domino).where(dominos: {:value => value}).take
    turn = current_turn
    turn.in_game_domino = domino
    current_turn.player.in_game_dominos << domino
  end

  def current_score
    current_turn.player.in_game_dominos.sum(&:nb_worms)
  end
end
