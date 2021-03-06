class Answer < ActiveRecord::Base
	belongs_to :question
	has_many :comments, dependent: :destroy
	belongs_to :question
	belongs_to :user
	has_many :upvote_answers
	has_many :downvote_answers

	validates :content, presence: :true
end
