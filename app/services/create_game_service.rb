class CreateGameService
  def call
    game = Game.create
    game.users << User.last
    game.save!
    game
  end
end
