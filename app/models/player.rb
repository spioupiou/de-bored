class Player < ApplicationRecord
  belongs_to :user
  belongs_to :instance
  has_many :player_inputs
end
