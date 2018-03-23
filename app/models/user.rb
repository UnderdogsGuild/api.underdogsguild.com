class User < ApplicationRecord
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :permissions

  has_secure_password

  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

end
