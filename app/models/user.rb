require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_secure_password
  
	validates :handle, presence: true
	validates :email, presence: true,uniqueness: true
	validates :password_digest, presence: true

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :favorite_questions, dependent: :destroy
  has_many :favorites, through: :favorite_questions, source: :question, dependent: :destroy
end
