class CommentsController < ApplicationController

	def new
		@answer = Answer.find(params[:answer_id])
	end

	def create
		@answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.create(content: params[:comment][:content], user_id: current_user.id)
    render "wow"
	end
end
