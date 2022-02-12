class PlayerInput < ApplicationRecord
  belongs_to :player
  belongs_to :instance
  validates :type, presence: true, inclusion: { in: %w[string boolean integer] } # can be modified later
  validates :value, presence: true
end
