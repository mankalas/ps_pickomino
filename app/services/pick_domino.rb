class PickDomino
  def initialize(game, value)
    @game = game
    @value = value.to_i
  end

  def call
    available_dominos = FetchAvailableDominos.new(@game).call
    current_turn = @game.current_turn

    if !available_dominos.empty? && current_turn.can_pick_domino?
      domino = available_dominos.detect { |dom| dom.value == @value }

      # Any turn ends with a domino pick.
      current_turn.update!(in_game_domino: domino)
      domino.update!(player: current_turn.player)

      PassTurn.new(@game).call
    end
  end
end
