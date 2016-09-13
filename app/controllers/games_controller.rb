class GamesController < ApplicationController
  before_action :find
  skip_before_action :find, only: [:create]

  def show
    @current_turn = @game.current_turn
  end

  def create
    @game = Game.create!
    SetupGame.new(@game).call
    redirect_to @game
  end

  def destroy
    @game.destroy
    redirect_to root_path
  end

  # Custom
  def roll_dice
    RollDice.new(@game).call
    redirect_to @game
  end

  def pick_dice
    PickDice.new(@game, pick_dice_params).call
    redirect_to @game
  end

  def pick_domino
    PickDomino.new(@game, pick_domino_params).call
    redirect_to @game
  end

  private

  def find
    @game = Game.find(params[:id])
  end

  def pick_dice_params
    params.require(:value)
  end

  def pick_domino_params
    params.require(:domino)
  end
end
