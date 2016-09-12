class FetchAvailableDominos
  def initialize(game)
    @game = game
  end

  def call
    dice_score = @game.current_turn.dice_score
    game_dominos = @game.dominos.joins(:domino).where("value <= #{dice_score}")
    players_dominos = @game.players.each.collect do |player|
      last_domino = player.last_domino
      last_domino if last_domino and last_domino.value <= dice_score
    end.compact
    game_dominos + players_dominos
  end
end
