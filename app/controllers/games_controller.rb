class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.create!
    SetupGame.new(@game).call
    redirect_to @game
  end

  # Custom
  def roll
    @game = Game.find(params[:id])
    ProgressTurn.new(@game.current_turn, params).call
    redirect_to @game
  end

  private

  def choice_params
    params.require(:value, :domino)
  end
end
