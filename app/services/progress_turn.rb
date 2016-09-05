class ProgressTurn
  def initialize(current_turn, choice)
    @current_turn = current_turn
    @choice = choice
  end

  def call
    if @choice.include?(:value)
      last_roll = @current_turn.rolls.last
      last_roll.pick = @choice[:value]
      last_roll.save!
      create_roll(last_roll.outcome.count(last_roll.pick))

    elsif @choice.include?(:domino)
      @current_turn.pick = Domino.find_by(value: @choice[:domino])

    else
      create_roll(8)
    end
  end

  private

  def create_roll(nb_dice)
    outcome = nb_dice.times.map { ((1..6).to_a.sample).to_s }.join.gsub('6', 'W')
    @current_turn.rolls.create(:outcome => outcome)
  end
end
