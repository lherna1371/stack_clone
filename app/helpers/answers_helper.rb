module AnswersHelper
	def votecount(answer)
		ups = answer.up_votes || 0
		downs = answer.down_votes || 0
		ups + downs
	end
end
