class DiscardDomino
  def initialize(game)
    @game = game
  end

  def call
    @game.in_game_dominos.delete(@game.dominos.max_by(&:value))
  end
end
