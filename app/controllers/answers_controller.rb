class AnswersController < ApplicationController
	
	def index
		if params[:user_id]
      @answers = User.find(params[:user_id]).answers
    else
      @answers = Answer.all
    end
	end

	def create
		Answer.create(:content => params[:answer][:content], :user_id => current_user.id, :question_id => params[:answer][:question_id].to_i,up_votes: 0,down_votes: 0) 
		redirect_to question_path(params[:answer][:question_id])
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
end
