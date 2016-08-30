require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:name) { "Chiche" }
  let(:player) { Player.new(name: name) }

  describe "Validation" do
    describe "name" do
      it "validates letters" do
        expect{ player.name = "qwe" }.not_to change{ player.valid? }
      end

      it "validates numbers" do
        expect{ player.name = "123" }.not_to change{ player.valid? }
      end

      it "validates symbolss" do
        expect{ player.name = "!@#" }.not_to change{ player.valid? }
      end

      it "validates spaces" do
        expect{ player.name = "a b c" }.not_to change{ player.valid? }
      end

      it "rejects only spaces" do
        expect{ player.name = "  " }.to change{ player.valid? }.from(true).to(false)
      end

      it "rejects empty string" do
        expect{ player.name = "" }.to change{ player.valid? }.from(true).to(false)
      end

      it "rejects nil" do
        expect{ player.name = nil }.to change{ player.valid? }.from(true).to(false)
      end

      it "rejects duplicates" do
        player.save
        player = Player.new(name: name)
        player.save
        expect(player).not_to be_valid
      end
    end

    describe "color" do
      it "validates correctly formatted hex color" do
        expect{ player.color = "#fabecc" }.not_to change{ player.valid? }
      end

      it "rejects too long hex" do
        expect{ player.color = "#1234567" }.to change{ player.valid? }.from(true).to(false)
      end

      it "rejects too short hex" do
        expect{ player.color = "#000" }.to change{ player.valid? }.from(true).to(false)
      end

      it "rejects no-hash hex" do
        expect{ player.color = "fabecc" }.to change{ player.valid? }.from(true).to(false)
      end

      it "rejects non-hex" do
        expect{ player.color = "#green" }.to change{ player.valid? }.from(true).to(false)
      end

      it "sets the color to #f71b6c if nil" do
        player.save # So the 'before_validation' callback is called
        expect(player.color).to eq "#f71b6c"
      end
    end
  end
end
