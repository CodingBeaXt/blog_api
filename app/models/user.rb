class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  has_secure_password
  has_secure_token :auth_token

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true

  before_create :ensure_auth_token_uniqueness

  # Invalidate the current token (logout)
  def invalidate_token
    self.update(auth_token: nil)
  end

  def ensure_auth_token_uniqueness
    while User.exists?(auth_token: self.auth_token)
      self.regenerate_auth_token
    end
  end
end
