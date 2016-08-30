class WelcomeController < ApplicationController
  def index
    @players = Player.all
    @games = Game.all
  end
end
