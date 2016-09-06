require 'rails_helper'

RSpec.describe Turn, type: :model do
  let(:game) { Game.create! }
  let(:user) { User.create!(name: "qwe", color: "#fabecc") }
  let(:player) { Player.create!(game: game, user: user) }
  let(:turn) { Turn.create!(game: game, player: player) }

  describe "#last_roll_outcome" do
    context "when no roll has been made" do
      it "returns nil if no roll has been made" do
        expect(turn.last_roll_outcome).to be_nil
      end
    end

    context "when a roll has been made" do
      let(:outcome) { '12312312' }

      it "returns the roll's outcome" do
        turn.rolls << Roll.create!(turn: turn, outcome: outcome, pick: '1')
        expect(turn.last_roll_outcome).to eq outcome
      end
    end

    context "when sevral rolls have been made" do
      let(:outcome) { '12312312' }

      it "returns the last roll's outcome" do
        5.times { |_| turn.rolls << Roll.create!(turn: turn, outcome: ('a'..'z').to_a.shuffle[0,8].join, pick: '1') }
        turn.rolls << Roll.create!(turn: turn, outcome: outcome, pick: '1')
        expect(turn.last_roll_outcome).to eq outcome
      end
    end
  end

  describe "#first_roll?" do
    context "No roll has been made" do
      it "returns true" do
        expect(turn.first_roll?).to be_truthy
      end
    end

    context "A roll has been made" do
      it "returns false" do
        turn.rolls.build
        turn.save!
        expect(turn.first_roll?).to be_falsey
      end
    end
  end

  describe "#pick_domino!" do

  end
end
