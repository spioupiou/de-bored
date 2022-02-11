class PlayerInput < ApplicationRecord
  belongs_to :player
  belongs_to :lobby
  validates :input_type, presence: true, inclusion: { in: %w[string boolean integer] } # can be modified later
  validates :input_value, presence: true
end
