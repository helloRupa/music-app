class User < ApplicationRecord
  attr_reader :password

  validates :email, :session_token, :password_digest, :activation_token, presence: true
  validates :email, :session_token, :activation_token, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  after_initialize :ensure_session_token, :ensure_activation_token

  has_many :notes,
    dependent: :destroy

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end
  
  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def ensure_activation_token
    self.activation_token ||= self.class.generate_activation_token
  end

  def self.generate_session_token
    generate_token(:find_by_session_token)
  end

  def self.generate_activation_token
    generate_token(:find_by_activation_token)
  end

  def self.generate_token(find_by_method)
    token = SecureRandom::urlsafe_base64(16)
    token = SecureRandom::urlsafe_base64(16) while User.send(find_by_method, token)
    token
  end

  def self.find_by_credentials(email, pw)
    user = User.find_by_email(email)
    return nil unless user
    user.is_password?(pw) ? user : nil
  end
end