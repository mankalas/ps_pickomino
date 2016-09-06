require 'rails_helper'

def mock_current_turn(game, turn)
  expect(game).to receive(:current_turn).and_return(turn)
end

RSpec.describe Game, type: :model do
  let(:game) { Game.create! }
  let(:user) { User.create!(name: "Chiche", color: "#fabecc") }
  let(:player) { Player.create!(user: user, game: game) }
  let(:turn) { game.turns.create!(player: player) }

  before do
    game.players << player
    game.save!
  end

  describe "#current_turn" do
    context "when there is no turn" do
      it "creates a new turn and returns it" do
        expect{ game.current_turn }.to change{ game.turns.count }.by(1)
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

  shared_examples "pass it to the current turn" do
    it "returns whatever the current turn returns" do
      mock_current_turn(game, turn)
      expect(turn).to receive(method).and_return(:something)

      expect(game.send(game_method)).to eq :something
    end
  end

  describe "#last_roll_outcome" do
    let(:method) { :last_roll_outcome }
    let(:game_method) { method }
    it_behaves_like "pass it to the current turn"
  end

  describe "#first_roll?" do
    let(:method) { :first_roll? }
    let(:game_method) { method }
    it_behaves_like "pass it to the current turn"
  end

  describe "#current_worm_score?" do
    let(:method) { :worm_score }
    let(:game_method) { :current_worm_score }
    it_behaves_like "pass it to the current turn"
  end

  describe "#pick_domino!" do
    it "removes the domino from the game" do
      domino = Domino.create!(value: 21, nb_worms: 1)
      mock_current_turn(game, turn)
      game.in_game_dominos << InGameDomino.create!(game: game, domino: domino)
      expect(turn).to receive(:pick_domino!)
      expect{ game.pick_domino!(21) }.to change{ game.in_game_dominos.count }.by(-1)
    end
  end
end
