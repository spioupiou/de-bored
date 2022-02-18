class Round < ApplicationRecord
  # numericality is to only accept positive values
  belongs_to :instance
  validates :number, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
