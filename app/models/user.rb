require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_secure_password
  
	validates :handle, presence: true
	validates :email, presence: true,uniqueness: true
	validates :password_digest, presence: true

  has_many :questions
  has_many :answers
  has_many :comments
end
