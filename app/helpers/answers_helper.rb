module AnswersHelper
	def a_votecount(answer)
		ups = answer.upvote_answers.count
		downs = answer.downvote_answers.count
		ups - downs
	end
end
