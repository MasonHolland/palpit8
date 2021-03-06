class User < ApplicationRecord
  has_many :messages
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :chatrooms, through: :messages
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
  validates :token, presence: true
  before_create :set_default_role
  before_validation :set_default_role


  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])
    user.email = auth['info']['email']
    user.name = auth['info']['name']
    user.username = auth['info']['nickname']
    user.token = auth['credentials']['token']

    user.save
    user
  end

  def admin?
    roles.exists?(name: "admin")
  end

  def registered_user?
    roles.exists?(name: "registered_user")
  end

  def twitch_profile(user_token)
    TwitchService.current_users_profile_info(user_token)
  end

  private

  def set_default_role
    Role.find_or_create_by(name: 'registered_user')
    self.roles << Role.find_by_name('registered_user')
  end
end
