require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:color) }

  it { should allow_values('qwe', '123', '!@#', 'q w e', '  ').for(:name) }
  it { should allow_values('#123456', '#fabecc').for(:color) }

  it { should_not allow_values('', nil).for(:name) }
  it { should_not allow_values('#1234567', '#000', '#color', 'fabecc').for(:color) }
end
