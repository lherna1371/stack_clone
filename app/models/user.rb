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

  def activate_account!
   update_attribute :is_active, true
 end

 def deactivate_account!
   update_attribute :is_active, false
 end
end
