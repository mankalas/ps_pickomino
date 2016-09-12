require 'rails_helper'

RSpec.describe Turn, type: :model do
  let(:game) { Game.create! }
  let(:player) { Player.create!(game: game, user: User.create!(name: "q")) }
  let(:turn) { game.turns.last }

  before do
    game.turns.build(player: player)
  end

  describe "#available_dice_values" do
    context "when no dice has been picked" do
      context "and when no roll has been made" do
        it "returns an empty array" do
          expect(turn.available_dice_values).to be nil
        end
      end

      context "and when a roll has been made" do
        let(:outcome) { '12345WW' }

        before do
          turn.rolls.build(outcome: outcome)
        end

        it "returns all of the outcome's value" do
          expect(turn.available_dice_values).to match outcome.chars.uniq
        end
      end
    end

    context "dice have been picked" do
      let(:outcome) { '123345WW' }
      let(:first_pick) { '2' }
      let(:second_pick) { 'W' }

      before do
        turn.rolls.build(outcome: outcome, pick: first_pick)
        turn.rolls.build(outcome: outcome, pick: second_pick)
      end

      context "and when no roll has been made" do
        it "returns an empty array" do
          expect(turn.available_dice_values).to match "1345".chars
        end
      end

      context "and when a roll has been made" do
        before do
          turn.rolls.build(outcome: outcome)
        end

        it "returns the outcome's values minus the values already taken" do
          expect(turn.available_dice_values).to match outcome.chars.uniq - [first_pick, second_pick]
        end
      end
    end
  end
end
