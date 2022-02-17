class Round < ApplicationRecord
  belongs_to :player_inputs

  # numericality is to only accept positive values
  validates :number, presence: true, numericality: { greater_than_or_equal_to: 0 }, default: 0
end
