class SetupGame
  def initialize(game, user_ids)
    @game = game
    @user_ids = user_ids
  end

  def call
    setup_in_game_dominos
    setup_players
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

  def setup_players
    @user_ids.each do |user_id|
      @game.players.create!(game: @game, user: User.find(user_id))
    end
  end
end
