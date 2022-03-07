class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar, dependent: :destroy

  before_validation :set_nickname, unless: :nickname
  after_commit :set_avatar, on: :create

  validates :username, uniqueness: true
  validates :username, :nickname, presence: true

  def email_required?
    false
  end

  private

  def set_nickname
    self.nickname = self.username
  end

  def set_avatar
    # dicebear doc: https://avatars.dicebear.com/docs/http-api
    dicebear_avatar_type = "bottts"                     # robots for genderbias and also kinda matches with our theme
    seed = rand(0..999).to_s << self.nickname.last(4)   # just a random seed so each user will have a unique robot avatar
    bg_color = "000d50"
    border_radius = "50"                                # 50px
    scale = "85"                                        # 85% so it could fit in the circular radius
    pixel_size = 60
    flip = rand(0..1)                                   # robots may face left or right
    file = URI.open("https://avatars.dicebear.com/api/#{dicebear_avatar_type}/#{seed}.png?b=%23#{bg_color}&r=#{border_radius}&size=#{pixel_size}&scale=#{scale}&flip=#{flip}")
    self.avatar.attach(io: file, filename: "#{self.username}.png", content_type: 'image/png')
  end
end
