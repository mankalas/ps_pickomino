class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @current_turn = @game.current_turn
  end

  def create
    @game = Game.create!
    SetupGame.new(@game).call
    redirect_to @game
  end

  # Custom
  def progress
    @game = Game.find(params[:id])
    ProgressTurn.new(@game, params).call
    redirect_to @game
  end

  private

  def choice_params
    params.require(:value, :domino)
  end
end
