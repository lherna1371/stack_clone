class Answer < ActiveRecord::Base
	belongs_to :question
	has_many :comments
	belongs_to :question
	belongs_to :user
	has_many :upvote_answers
	has_many :downvote_answers
end
