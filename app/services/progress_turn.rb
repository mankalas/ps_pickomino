class ProgressTurn
  def initialize(game, choice)
    @game = game
    @current_turn = @game.current_turn
    @choice = choice
  end

  def call
    if @choice.include?(:value) && @current_turn.rolls.last.pick.nil?
      pick_value!(@choice[:value])
      create_roll!(dice_remaining) unless @current_turn.can_pick_domino?

    elsif @choice.include?(:domino) && !@choice[:domino].empty?
      PickDomino.new(@game, @choice[:domino].to_i).call

    else
      create_roll!(@current_turn.rolls.empty? ? 8 : dice_remaining)
    end
  end

  private

  def pick_value!(value)
    last_roll = @current_turn.rolls.last
    last_roll.pick = @choice[:value]
    last_roll.save!
  end

  def dice_remaining
    last_roll = @current_turn.rolls.last
    last_roll.outcome.length - last_roll.outcome.count(last_roll.pick)
  end

  def create_roll!(nb_dice)
    outcome = nb_dice.times.map { ((1..6).to_a.sample).to_s }.join.gsub('6', 'W')
    @current_turn.rolls.create!(:outcome => outcome)
  end
end
