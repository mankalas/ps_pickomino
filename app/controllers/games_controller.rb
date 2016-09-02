class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def create
    redirect_to CreateGameService.new.call
  end
end
