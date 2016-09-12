require 'rails_helper'

def mock_current_turn(game, turn)
  expect(game).to receive(:current_turn).and_return(turn)
end

RSpec.describe Game, type: :model do
  fixtures :games
  fixtures :users
  fixtures :players

  let(:game) { games(:game) }
  let(:user) { users(:user) }
  let(:player) { players(:player) }
  let(:turn) { game.current_turn }

  before do
    game.players << player
    game.save!
  end

  describe "#current_turn" do
    context "when there is no turn" do
      it "returns nil" do
        expect(game.current_turn).to be_nil
      end
    end

    context "when there is only one turn" do
      it "returns the turn" do
        turn = game.turns.create!(player: player)

        expect(game.current_turn).to eq turn
      end
    end

    context "when there are several turns" do
      it "returns the last created one" do
        5.times { |_| game.turns.create!(player: player) }
        turn = game.turns.create!(player: player)

        expect(game.current_turn).to eq turn
      end
    end
  end
end
