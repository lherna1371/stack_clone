class CommentsController < ApplicationController

	def new
		if params[:answer_id]
			@resource = Answer.find(params[:answer_id])
		elsif params[:question_id]
			@resource = Question.find(params[:question_id])
		end
	end

	def create

		if params[:comment][:content].blank?
			# @error = "You submitted a blank comment try again"
			flash[:error] = "You submitted a blank comment try again"
			redirect_to new_answer_comment_path(params[:answer_id])
			return
		end

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
