class PickDice
  attr_reader :notice

  def initialize(game, value)
    @game = game
    @value = value
    @notice = nil
  end

  def call
    current_turn = @game.current_turn
    if current_turn.rolls.present?
      last_roll = current_turn.rolls.last
      last_roll.update!(:pick => @value) if last_roll.pick.nil?

      if !current_turn.can_pick_domino?

        @notice = "You can't pick a domino, so a roll has automatically been made."
        RollDice.new(@game).call
      end
    end
  end
end
