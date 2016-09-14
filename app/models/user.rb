class User < ApplicationRecord
  # Association
  has_many :players
  has_many :games, through: :players

  # Validation
  validates :name,
            :presence => { :message => "The name can't be blank" },
            :uniqueness => true
  validates :color,
            :presence => true,
            :format => { :with => /\A\#\h{6}\z/,
                         :message => "Color must be \#xxxxxx" }

  # Callback
  before_validation :init_color, on: :create

  def init_color
    self.color = '#f71b6c' if color == nil || color.empty?
  end
end
