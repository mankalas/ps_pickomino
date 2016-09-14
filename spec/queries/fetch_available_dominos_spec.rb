require 'rails_helper'

def create_outcome(outcome, pick)
  game.current_turn.rolls.create!(:outcome => outcome, :pick => pick)
end

RSpec.describe FetchAvailableDominos, type: :service do
  fixtures :users

  let(:bob) { users(:bob) }
  let(:alice) { users(:alice) }
  let(:game) { CreateGame.new([bob.id, alice.id]).call }
  let(:player1) { game.players.first }
  let(:player2) { game.players.second }
  let(:dom_21) { InGameDomino.create!(:game => game, :domino => Domino.create!(:value => 21)) }
  let(:dom_22) { InGameDomino.create!(:game => game, :domino => Domino.create!(:value => 22)) }
  let(:dom_23) { InGameDomino.create!(:game => game, :domino => Domino.create!(:value => 23)) }
  let(:dom_24) { InGameDomino.create!(:game => game, :domino => Domino.create!(:value => 24)) }
  let(:dom_31) { InGameDomino.create!(:game => game, :domino => Domino.create!(:value => 31)) }
  let(:query) { FetchAvailableDominos.new(game) }

  before do
    game.in_game_dominos << dom_21 << dom_22
  end

  describe "Fetch available dominos in the game" do
    context "when no player has any domino" do
      before do
        game.turns.create!(:game => game, :player => player1)
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
        game.turns.create!(:game => game, :player => player1, :in_game_domino => dom_23)
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
        game.turns.create!(:game => game, :player => player1, :in_game_domino => dom_23)
        game.turns.create!(:game => game, :player => player1, :in_game_domino => dom_31)
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
        game.turns.create!(:game => game, :player => player1, :in_game_domino => dom_23)
        game.turns.create!(:game => game, :player => player1, :in_game_domino => dom_31)
        game.turns.create!(:game => game, :player => player2, :in_game_domino => dom_24)
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
