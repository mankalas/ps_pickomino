class PlayersController < ApplicationController
  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to root_path
    else
      redirect_to new_player_path, notice: @player.errors
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :color)
  end
end
