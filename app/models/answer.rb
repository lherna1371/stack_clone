class Answer < ActiveRecord::Base
	belongs_to :question
	has_many :comments

	def votecount
			self.up_votes + self.down_votes
	end
end
