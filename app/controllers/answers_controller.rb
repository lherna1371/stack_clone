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
				flash[:error] = "Answer was not Saved"
				redirect_to question_path(@answer.question)
			end
		else
			flash[:error] = "You must be logged in to answer"
			redirect_to login_path
		end
	end

	def update
		@answer = Answer.find(params[:id])
		if current_user && (current_user.admin || current_user.id == @answer.user_id)
			@answer.update_attributes(answer_attributes)
			redirect_to @answer.question
		else
			flash[:error] = 'You must log in first'
			redirect_to @answer
		end
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
		if current_user
			answer = Answer.find(params[:format])
			if answer.downvote_answers.where(:user_id => current_user.id).empty?
				UpvoteAnswer.create(:user_id => current_user.id, :answer_id => answer.id)
			else
				answer.downvote_answers.where(:user_id => current_user.id).first.destroy
			end
		end
		redirect_to :back
	end

	def downvote
		if current_user
			answer = Answer.find(params[:format])
			if answer.upvote_answers.where(:user_id => current_user.id).empty?
				DownvoteAnswer.create(:user_id => current_user.id, :answer_id => answer.id)
			else
				answer.upvote_answers.where(:user_id => current_user.id)[0].destroy
			end
		end
		redirect_to :back
	end

	private
	def answer_attributes
  	params.require(:answer).permit(:content)
  end
end
