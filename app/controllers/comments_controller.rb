class CommentsController < ApplicationController

	def new
		@answer = Answer.find(params[:answer_id])
	end

	def create
		@answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.create(params[:comment].merge({:user_id => current_user.id}))
    redirect_to @answer
	end

end
