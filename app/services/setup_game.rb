class SetupGame
  def initialize(game)
    @game = game
  end

  def call
    setup_in_game_dominos
    @game.turns.create!(player: @game.players.last, index: 1)
  end

  private

  def setup_in_game_dominos
    Domino.all.each do |domino|
      @game.in_game_dominos.create!(game: @game, domino: domino)
    end
    # For testing, to shorter the game
    #@game.in_game_dominos << InGameDomino.create!(game: @game, domino: Domino.first)
  end
end
