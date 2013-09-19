class AnswersController < ApplicationController

	def create
		Answer.create(:content => params[:answer][:content], :user_id => current_user.id, :question_id => params[:answer][:question_id].to_i) 
		redirect_to question_path(params[:answer][:question_id])
	end
end
