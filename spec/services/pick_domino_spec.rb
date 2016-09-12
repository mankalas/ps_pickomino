require 'rails_helper'

RSpec.describe PickDomino, type: :service do
  fixtures :games, :users, :players, :turns

  let(:game) { games(:game) }
  let(:user) { users(:user) }
  let(:player1) { players(:player1) }
  let(:value) { 21 }
  let(:domino) { InGameDomino.create!(game: game, domino: Domino.create!(value: value, nb_worms: 1)) }

  describe "#pick_domino!" do
    before do
      game.players << player1
      game.turns.create!(game: game, player: player1)
    end

    context "when the picked domino is not owned by anybody" do
      before do
        game.current_turn.rolls.create!(outcome: 'WWWWWW', pick: 'W')
        game.current_turn.rolls.create!(outcome: '123')
        game.in_game_dominos << domino
      end

      it "removes the domino from the game" do
        expect(game.dominos).to match_array [domino]
        PickDomino.new(game, value).call
        expect(game.dominos).to match_array []
      end

      it "changes the ownership of the domino to the player" do
        expect(player1.in_game_dominos).to match_array []
        PickDomino.new(game, value).call
        expect(player1.reload.in_game_dominos).to match_array [domino]
      end
    end

    context "when the picked domino is owner by a player" do
      let(:player2) { players(:player2) }

      before do
        # Player2 joins the game
        game.players << player2
        # Ends the current turn with a pick
        game.current_turn.update!(in_game_domino: domino)
        # Player1 has the domino
        player1.in_game_dominos << domino
        # Create a new turn for player2
        game.turns.create!(game: game, player: player2)
        # Roll the dice
        game.current_turn.rolls.create!(outcome: 'WWWWWW', pick: 'W')
        game.current_turn.rolls.create!(outcome: '123')
      end

      it "removes the first player's ownership of the domino" do
        expect(player1.in_game_dominos).to match_array [domino]
        PickDomino.new(game, value).call
        expect(player1.reload.in_game_dominos).to match_array []
      end

      it "changes the ownership of the domino to the other player" do
        expect(player2.in_game_dominos).to match_array []
        PickDomino.new(game, value).call
        expect(player2.reload.in_game_dominos).to match_array [domino]
      end
    end
  end
end
