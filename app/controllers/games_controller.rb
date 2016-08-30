class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new
    @game.save!
    redirect_to @game
  end
end
