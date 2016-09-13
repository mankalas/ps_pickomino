class RollDice
  def initialize(game, generator = nil)
    @game = game
    @current_turn = @game.current_turn
    @generator = generator
  end

  def call
    nb_dice = @current_turn.rolls.empty? ? 8 : dice_remaining
    outcome = if @generator
                @generator.call
              else
                nb_dice.times.map { ((1..6).to_a.sample).to_s }.join.gsub('6', 'W')
              end
    @current_turn.rolls.create!(:outcome => outcome)
    DiscardDomino.new(@game).call if @current_turn.lost?
  end

  private

  def dice_remaining
    last_roll = @current_turn.rolls.last
    last_roll_outcome = @current_turn.last_roll_outcome
    last_roll_outcome.length - last_roll_outcome.count(last_roll.pick)
  end
end

class GenerateFixedOutcome
  def initialize(outcome)
    @outcome = outcome
  end

  def call
    @outcome
  end
end
