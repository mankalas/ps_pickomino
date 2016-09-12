class PickDice
  def initialize(game, value)
    @game = game
    @current_turn = @game.current_turn
    @value = value
  end

  def call
    if @current_turn.rolls.last.pick.nil?
      @current_turn.rolls.last.update!(:pick => @value)
    end
  end
end
