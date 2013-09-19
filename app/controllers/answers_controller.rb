class AnswersController < ApplicationController
	
	def index
		if params[:user_id]
      @answers = User.find(params[:user_id]).answers
    else
      @answers = Answer.all
    end
	end

	def create
		Answer.create(:content => params[:answer][:content], :user_id => current_user.id, :question_id => params[:answer][:question_id].to_i) 
		redirect_to question_path(params[:answer][:question_id])
	end
end
