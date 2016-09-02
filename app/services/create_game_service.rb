class CreateGameService
  def call
    game = Game.create
    Domino.all.each do |domino|
      game.in_game_dominos << InGameDomino.create(game: game, domino: domino, player: nil)
    end
    game.users << User.last
    game.save!
    game
  end
end
