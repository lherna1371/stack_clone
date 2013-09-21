class Answer < ActiveRecord::Base
	belongs_to :question
	has_many :comments, dependent: :destroy
	belongs_to :question
	belongs_to :user
end
