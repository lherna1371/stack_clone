class CommentsController < ApplicationController

	def new
		#@answer = Answer.find(params[:answer_id])
		if params[:answer_id]
			@resource = Answer.find
		elsif params[:question_id]
			

	end

	def create
		@answer = Answer.find(params[:answer_id])
		@question = Question.find(@answer.question_id)
    @comment = @answer.comments.create(content: params[:comment][:content], user_id: current_user.id)
    redirect_to @question
	end
end
