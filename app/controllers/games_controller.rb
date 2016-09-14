class GamesController < ApplicationController
  before_action :find
  skip_before_action :find, only: [:create, :new]

  def show
    @current_turn = @game.current_turn
  end

  def new
    @game = Game.new
  end

  def create
    @game = CreateGame.new(params[:game][:user_ids]).call
    if @game.valid?
      redirect_to @game
    else
      redirect_to new_game_path, notice: @game.errors
    end
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

  def pass
    PassTurn.new(@game).call
    redirect_to @game
  end

  private

  def find
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(user_ids: [])
  end

  def pick_dice_params
    params.require(:value)
  end

  def pick_domino_params
    params.require(:domino)
  end
end
