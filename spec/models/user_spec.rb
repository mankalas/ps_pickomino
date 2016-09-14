require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  let(:user) { users(:bob) }

  describe "Validation" do
    describe "name" do
      it "validates letters" do
        expect{ user.name = "qwe" }.not_to change{ user.valid? }
      end

      it "validates numbers" do
        expect{ user.name = "123" }.not_to change{ user.valid? }
      end

      it "validates symbolss" do
        expect{ user.name = "!@#" }.not_to change{ user.valid? }
      end

      it "validates spaces" do
        expect{ user.name = "a b c" }.not_to change{ user.valid? }
      end

      it "rejects only spaces" do
        expect{ user.name = "  " }.to change{ user.valid? }.from(true).to(false)
      end

      it "rejects empty string" do
        expect{ user.name = "" }.to change{ user.valid? }.from(true).to(false)
      end

      it "rejects nil" do
        expect{ user.name = nil }.to change{ user.valid? }.from(true).to(false)
      end

      it "rejects duplicates" do
        new_user = User.create(name: user.name)
        expect(new_user).not_to be_valid
      end
    end

    describe "color" do
      it "validates correctly formatted hex color" do
        expect{ user.color = "#fabecc" }.not_to change{ user.valid? }
      end

      it "rejects too long hex" do
        expect{ user.color = "#1234567" }.to change{ user.valid? }.from(true).to(false)
      end

      it "rejects too short hex" do
        expect{ user.color = "#000" }.to change{ user.valid? }.from(true).to(false)
      end

      it "rejects no-hash hex" do
        expect{ user.color = "fabecc" }.to change{ user.valid? }.from(true).to(false)
      end

      it "rejects non-hex" do
        expect{ user.color = "#green" }.to change{ user.valid? }.from(true).to(false)
      end

      it "sets the color to #f71b6c if nil" do
        expect(User.create!(name: "t").color).to eq "#f71b6c"
      end
    end
  end
end
