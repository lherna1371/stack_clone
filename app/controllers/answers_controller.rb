class AnswersController < ApplicationController
	helper AnswersHelper
	def index
		if params[:user_id]
      @answers = User.find(params[:user_id]).answers
    else
      @answers = Answer.all
    end
	end

	def create
		if current_user
			@answer = Answer.new(:content => params[:answer][:content], :user_id => current_user.id, :question_id => params[:answer][:question_id].to_i,up_votes: 0,down_votes: 0)
			if @answer.save
				redirect_to @answer.question
			else
				redirect :back
			end
		else
			flash[:error] = "You must be logged in to answer"
			redirect_to login_path
		end
	end

	def update
		@answer = Answer.find(params[:id])
		@answer.update_attributes(answer_attributes)
		redirect_to @answer.question
	end

	def edit
			@answer = Answer.find(params[:id])
		if current_user && (current_user.admin || current_user.id == @answer.user_id)
		else
			flash[:error] = "You must log in first"
			redirect_to login_path
		end
	end

	def upvote
		answer = Answer.find(params[:format])
		answer.up_votes += 1
		answer.save
		redirect_to question_path(answer.question_id)
	end

	def downvote
		answer = Answer.find(params[:format])
		answer.down_votes -= 1
		answer.save
		redirect_to question_path(answer.question_id)
	end

	private
	def answer_attributes
  	params.require(:answer).permit(:content)
  end
end
