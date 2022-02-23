class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true
  validates :username, :nickname, presence: true
  before_create :set_nickname

  def email_required?
    false
  end

  private

  def set_nickname
    self.nickname = self.username
  end
end
