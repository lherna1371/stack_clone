require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
	validates :handle, presence: true
	validates :email, presence: true,uniqueness: true
	validates :password_digest, presence: true

  has_many :quesions
  has_many :answers
  has_many :comments

	def self.authenticate(name, secret)
    user = find_by_name(name)
    if user && user.password == secret
      return user
    end
  end

  def password
    @password = Password.new(password_digest)
  end

  def password=(secret)
    @password = Password.create(secret)
    self.password_digest = @password
  end
end
