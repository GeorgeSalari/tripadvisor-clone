class User < ApplicationRecord
  enum role: [ :customers, :owner ]
  has_secure_password
  validates :password, :length => { :minimum => 6 }, allow_blank: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\w+@\w+\.{1}[a-zA-Z]{2,}/, message: "incorect email"}
  has_many :hotels, dependent: :destroy
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.password = SecureRandom.hex
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def capitalize_name
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
  end
end
