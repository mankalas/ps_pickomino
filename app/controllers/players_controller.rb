class PlayersController < ApplicationController
  before_action :find, only: [:edit, :update, :destroy]

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to root_path
    else
      redirect_to new_player_path, notice: @player.errors
    end
  end

  def update
    if @player.update(player_params)
      redirect_to root_path
    else
      redirect_to edit_player(@player), notice: @player.errors
    end
  end

  def destroy
    @player.destroy
    redirect_to root_path
  end

  private

  def player_params
    params.require(:player).permit(:name, :color)
  end

  def find
    @player = Player.find(params[:id])
  end
end
