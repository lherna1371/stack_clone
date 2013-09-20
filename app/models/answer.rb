class Answer < ActiveRecord::Base
	has_many :comments

	def votecount
			self.up_votes + self.down_votes
	end
end
