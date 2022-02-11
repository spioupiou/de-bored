class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true
  before_create :set_nickname

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  private

  def set_nickname
    self.nickname = self.username
  end
end
