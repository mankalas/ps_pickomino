class User < ApplicationRecord
  # Association
  has_and_belongs_to_many :games

  # Validation
  validates :name,
            presence: true,
            uniqueness: true
  validates :color,
            presence: true,
            format: { with: /\A\#\h{6}\z/, message: "color must be \#xxxxxx"}

  # Callback
  before_validation :init_color, on: :create

  def init_color
    self.color = '#f71b6c' if color == nil || color.empty?
  end
end
