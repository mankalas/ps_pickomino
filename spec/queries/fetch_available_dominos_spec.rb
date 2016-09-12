require 'rails_helper'

def create_dummy_in_game_domino(value)
  InGameDomino.create!(game: game, domino: Domino.create!(value: value))
end

def create_outcome(outcome, pick)
  game.current_turn.rolls.create!(outcome: outcome, pick: pick)
end

RSpec.describe FetchAvailableDominos, type: :service do
  fixtures :games
  fixtures :users
  fixtures :players
  fixtures :turns

  let(:game) { games(:game) }
  let(:user) { users(:user) }
  let(:player1) { players(:player1) }
  let(:player2) { players(:player2) }
  let(:dom_21) { create_dummy_in_game_domino(21) }
  let(:dom_22) { create_dummy_in_game_domino(22) }
  let(:dom_23) { create_dummy_in_game_domino(23) }
  let(:dom_24) { create_dummy_in_game_domino(24) }
  let(:dom_31) { create_dummy_in_game_domino(31) }
  let(:query) { FetchAvailableDominos.new(game) }

  before do
    game.players << player1 << player2
    game.in_game_dominos << dom_21 << dom_22
  end

  describe "Fetch available dominos in the game" do
    context "when no player has any domino" do
      before do
        game.turns.create!(game: game, player: player1)
      end

      context "when the dice score is small" do
        it "returns an empty array" do
          create_outcome('1', '1')
          expect(query.call).to match_array []
        end
      end

      context "when the dice score is huge" do
        it "returns only the game's dominos" do
          create_outcome('55555555', '5')
          expect(query.call).to match_array [dom_21, dom_22]
        end
      end
    end

    context "when player1 has one domino" do
      before do
        game.turns.create!(game: game, player: player1, in_game_domino: dom_23)
        dom_23.update!(:player => player1)
      end

      context "when the dice score is small" do
        it "returns an empty array" do
          create_outcome('1', '1')
          expect(query.call).to match_array []
        end
      end

      context "when the dice score is huge" do
        it "returns every dominos" do
          create_outcome('55555555', '5')
          expect(query.call).to match_array [dom_21, dom_22, dom_23]
        end
      end
    end

    context "when player1 has several dominos" do
      before do
        game.turns.create!(game: game, player: player1, in_game_domino: dom_23)
        game.turns.create!(game: game, player: player1, in_game_domino: dom_31)
        dom_23.update!(:player => player1)
        dom_31.update!(:player => player1)
      end

      context "when the dice score is small" do
        it "returns an empty array" do
          create_outcome('1', '1')
          expect(query.call).to match_array []
        end
      end

      context "when the dice score is huge" do
        it "returns every dominos" do
          create_outcome('55555555', '5')
          expect(query.call).to match_array [dom_21, dom_22, dom_31]
        end
      end
    end

    context "when two players has dominos" do
      before do
        game.turns.create!(game: game, player: player1, in_game_domino: dom_23)
        game.turns.create!(game: game, player: player1, in_game_domino: dom_31)
        game.turns.create!(game: game, player: player2, in_game_domino: dom_24)
        dom_23.update!(:player => player1)
        dom_31.update!(:player => player1)
        dom_24.update!(:player => player2)
      end

      context "when the dice score is small" do
        it "returns an empty array" do
          create_outcome('1', '1')
          expect(query.call).to match_array []
        end
      end

      context "when the dice score is huge" do
        it "returns every dominos" do
          create_outcome('55555555', '5')
          expect(query.call).to match_array [dom_21, dom_22, dom_24, dom_31]
        end
      end
    end
  end
end
