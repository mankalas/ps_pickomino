class PickDice
  def initialize(game, value)
    @game = game
    @current_turn = @game.current_turn
    @value = value
  end

  def call
    if @current_turn.rolls.present?
      last_roll = @current_turn.rolls.last
      last_roll.update!(:pick => @value) if last_roll.pick.nil?
    end
  end
end
