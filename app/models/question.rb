class Question < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :title
	validates_presence_of :content
	validates_presence_of :user_id


	def votecount
		if self.up_votes == nil || self.down_votes == nil
			0
		else
			self.up_votes + self.down_votes
		end
	end
end
