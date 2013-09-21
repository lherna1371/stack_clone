module QuestionsHelper
	def q_votecount(question)
		ups = question.upvote_questions.count || 0
		downs = question.downvote_questions.count || 0
		ups - downs
	end
end