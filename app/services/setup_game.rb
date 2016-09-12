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
end
