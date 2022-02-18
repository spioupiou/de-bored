class Player < ApplicationRecord
  belongs_to :user
  belongs_to :instance
  has_many :player_inputs, dependent: :destroy

  validates :user_id, uniqueness: { scope: :instance_id }
end
