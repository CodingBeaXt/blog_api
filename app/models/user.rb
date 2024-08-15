class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  has_secure_password
  has_secure_token :auth_token

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true

  # Invalidate the current token (logout)
  def invalidate_token
    self.update(auth_token: nil)
  end
end
