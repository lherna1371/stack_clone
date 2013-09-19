class CommentsController < ApplicationController

	def new
		#@answer = Answer.find(params[:answer_id])
		if params[:answer_id]
			@resource = Answer.find(params[:answer_id])
		elsif params[:question_id]
			@resource = Question.find(params[:question_id])
		end
	end

	def create


		if params[:answer_id]
			@answer = Answer.find(params[:answer_id])
			@question = Question.find(@answer.question_id)
	    	@comment = @answer.comments.create(content: params[:comment][:content], user_id: current_user.id)
		elsif params[:question_id]
			@question = Question.find(params[:question_id])
	    	@comment = @question.comments.create(content: params[:comment][:content], user_id: current_user.id)
		end
    	redirect_to @question
	end
end
