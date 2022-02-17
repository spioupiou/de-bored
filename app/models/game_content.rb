class GameContent < ApplicationRecord
  belongs_to :rounds
  validates :content, presence: true
end
