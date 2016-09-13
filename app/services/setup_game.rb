class SetupGame
  def initialize(game)
    @game = game
  end

  def call
    setup_in_game_dominos

    if User.count == 0
      user = User.create!(name: "Dummy", color: "#00ffee")
    else
      user = User.last
    end

    @game.players.create(user: user, game: @game)
    @game.turns.create(player: @game.players.last, index: 1)
    @game.save!
  end

  private

  def setup_in_game_dominos
    Domino.all.each do |domino|
      @game.in_game_dominos << InGameDomino.create!(game: @game, domino: domino)
    end
    # For testing, to shorter the game
    #@game.in_game_dominos << InGameDomino.create!(game: @game, domino: Domino.first)
  end
end
