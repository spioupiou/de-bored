class Instance < ApplicationRecord
  belongs_to :game
  belongs_to :user # host
  has_many :players, dependent: :destroy
  has_many :player_inputs, dependent: :destroy

  validates :status, presence: true, inclusion: { in: ['waiting', 'ongoing', 'done'] }
  
  enum status: { waiting: 'waiting', ongoing: 'ongoing', done: 'done' }
end
