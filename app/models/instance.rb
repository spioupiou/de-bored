class Instance < ApplicationRecord
  belongs_to :game
  belongs_to :user # host
  has_many :player_inputs

  validates :status, presence: true, inclusion: { in: %w[pending ongoing completed] }
end
