class CreateGame
  def initialize(user_ids)
    @user_ids = user_ids.map(&:to_s).reject(&:empty?)
  end

  def call
    game = Game.new
    @user_ids.each do |user_id|
      game.players.build(user: User.find(user_id))
    end
    SetupGame.new(game).call if game.save
    game
  end
end
