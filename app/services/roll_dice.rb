class RollDice
  def initialize(game)
    @game = game
    @current_turn = @game.current_turn
  end

  def call
    nb_dice = @current_turn.rolls.empty? ? 8 : dice_remaining
    outcome = nb_dice.times.map { ((1..6).to_a.sample).to_s }.join.gsub('6', 'W')
    @current_turn.rolls.create!(:outcome => outcome)
  end

  private

  def dice_remaining
    last_roll = @current_turn.rolls.last
    last_roll_outcome = @current_turn.last_roll_outcome
    last_roll_outcome.length - last_roll_outcome.count(last_roll.pick)
  end
end
