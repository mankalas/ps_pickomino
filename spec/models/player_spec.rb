require 'rails_helper'

def add_domino_to_player(nb_worms, game)
  player.in_game_dominos.create!(domino: Domino.create!(:value => 0, :nb_worms => nb_worms), :game => game)
end

def create_turn_with_domino(game, player, value, nb_worms)
  domino = Domino.create!(:value => value, :nb_worms => nb_worms)
  in_game_domino = InGameDomino.create!(:domino => domino, :game => game)
  game.turns.create!(:player => player, :game => game, :in_game_domino => in_game_domino)
end

RSpec.describe Player, type: :model do
  fixtures :users

  let(:user) { users(:bob) }
  let(:game) { CreateGame.new([user.id]).call }
  let(:player) { game.players.take }

  describe "#worm_score" do
    context "when the player has no domino" do
      it "returns 0" do
        expect(player.worm_score).to eq 0
      end
    end

    context "when the player has one domino" do
      let(:nb_worms) { 4 }

      it "returns the domino's number of worms" do
        add_domino_to_player(nb_worms, game)
        expect(player.worm_score).to eq nb_worms
      end
    end

    context "when the player has several dominos" do
      it "returns the sum of all dominos number of worms" do
        add_domino_to_player(3, game)
        add_domino_to_player(4, game)
        expect(player.worm_score).to eq 7
      end
    end
  end

  describe "#last_domino" do
    context "when the player has no domino" do
      it "returns nil" do
        expect(player.last_domino).to be_nil
      end
    end

    context "when the players has one domino" do
      it "returns the one domino" do
        create_turn_with_domino(game, player, 1, 1)
        expect(player.last_domino.value).to eq 1
      end
    end

    context "when the player has several dominos" do
      it "returns the domino that has been picked up last" do
        3.times { |i| create_turn_with_domino(game, player, i, i) }
        expect(player.last_domino.value).to eq 2
      end
    end
  end
end
