module QuestionsHelper
	def q_votecount(question)
		ups = question.upvote_questions.count
		downs = question.downvote_questions.count
		ups - downs
	end
end