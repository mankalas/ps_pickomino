class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.create!
    SetupGame.new(@game).call
    redirect_to @game
  end
end
