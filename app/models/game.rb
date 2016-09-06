class Game < ApplicationRecord
  # Association
  has_many :players
  has_many :turns
  has_many :users, through: :players
  has_many :in_game_dominos

  def current_turn
    raise Exception if players.empty?
    turns.create!(player: players.take) if turns.empty?
    turns.order(:created_at).last
  end

  def last_roll_outcome
    current_turn.last_roll_outcome
  end

  def first_roll?
    current_turn.first_roll?
  end

  def current_worm_score
    current_turn.worm_score
  end

  def pick_domino!(value)
    domino = retrieve_domino_by_value(value)

    in_game_dominos.delete(domino)
    save!

    current_turn.pick_domino!(domino)
  end

  private

  def retrieve_domino_by_value(value)
    in_game_dominos.joins(:domino).where(dominos: {:value => value}).take
  end
end
