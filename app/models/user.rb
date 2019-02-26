class User < ActiveRecord::Base
  has_secure_password

  validates :password, presence: true, on: :create, length: { minimum: 8 }
  validates :password, length: { minimum: 8 }, allow_nil: true, on: :update

  validates :name, length: { minimum: 5 }, on: :update

  validates :email, presence: true, uniqueness: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  before_create :extract_name

  private

  def extract_name
    self.name = email.split('@').first
  end

end
