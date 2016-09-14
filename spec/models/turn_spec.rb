require 'rails_helper'

RSpec.describe Turn, type: :model do
  fixtures :users

  let(:user) { users(:bob) }
  let(:game) { CreateGame.new([user.id]).call }
  let(:player) { game.players.take }
  let(:turn) { game.turns.last }

  before do
    game.turns.create!(:player => player)
  end

  describe "#available_dice_values" do
    context "when no dice has been picked" do
      context "and when no roll has been made" do
        it "returns nil" do
          expect(turn.available_dice_values).to be nil
        end
      end

      context "and when a roll has been made" do
        let(:outcome) { '12345WW' }

        before do
          turn.rolls.create!(:outcome => outcome)
        end

        it "returns all of the outcome's values" do
          expect(turn.available_dice_values).to match outcome.chars.uniq
        end
      end
    end

    context "when dice have been picked" do
      let(:outcome) { '123345WW' }
      let(:first_pick) { '2' }
      let(:second_pick) { 'W' }

      before do
        turn.rolls.create!(:outcome => outcome, :pick => first_pick)
        turn.rolls.create!(:outcome => outcome, :pick => second_pick)
      end

      context "and when no roll has been made" do
        it "returns the remaining possible values" do
          expect(turn.available_dice_values).to match_array ("12345W".chars - [first_pick, second_pick])
        end
      end

      context "and when a roll has been made" do
        before do
          turn.rolls.create!(:outcome => outcome)
        end

        it "returns the outcome's values minus the values already taken" do
          expect(turn.available_dice_values).to match_array (outcome.chars.uniq - [first_pick, second_pick])
        end
      end
    end
  end
end
