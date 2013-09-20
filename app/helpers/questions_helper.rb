module QuestionsHelper
	def votecount(question)
		ups = question.up_votes || 0
		downs = question.down_votes || 0
		ups + downs
	end
end