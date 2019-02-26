class User < ActiveRecord::Base
  TOKEN_EXPIRES_IN = 6.hours
  has_secure_password

  validates :password, presence: true, on: :create, length: { minimum: 8 }
  validates :password, length: { minimum: 8 }, allow_nil: true, on: :update

  validates :name, length: { minimum: 5 }, on: :update

  validates :email, presence: true, uniqueness: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  before_create :extract_name, :generate_token

  def token_reset
    generate_token(:reset_token)
    self.reset_token_sent_at = Time.zone.now
    save!
  end

  private

  def extract_name
    self.name = email.split('@').first
  end

  def generate_token(column = :token)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
