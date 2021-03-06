class User < ActiveRecord::Base
  has_many :authentications, :dependent => :delete_all
  has_many :access_grants, :dependent => :delete_all

  before_validation :initialize_fields, :on => :create

  devise :invitable, :database_authenticatable, :token_authenticatable,
         :recoverable, :trackable, :validatable, :rememberable

  self.token_authentication_key = "oauth_token"

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_for_token_authentication(conditions)
    where(["access_grants.access_token = ? AND (access_grants.access_token_expires_at IS NULL OR access_grants.access_token_expires_at > ?)", conditions[token_authentication_key], Time.now]).joins(:access_grants).select("users.*").first
  end
  
  def initialize_fields
    self.status = "Active"
    self.expiration_date = 1.year.from_now
  end
end
