class User < ApplicationRecord
  has_many :rentals, foreign_key: 'renter_id'
  validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :name, :email
  has_secure_password
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      userpass = SecureRandom.hex(10)
      user.password = userpass
      user.password_confirmation = userpass
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
