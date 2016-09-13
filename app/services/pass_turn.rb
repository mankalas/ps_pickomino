class PassTurn
  def initialize(game)
    @game = game
  end

  def call
    players = @game.players
    current_player = @game.current_turn.player
    next_player = players.where('id > ?', current_player.id).order(:id => :desc).first || players.first
    @game.turns.create!(:player => next_player, :game => @game)
  end
end
