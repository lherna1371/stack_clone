class AnswersController < ApplicationController

	def create
		# puts "++++++++++++++++++++++++++++++++++++++"
		# puts current_user.id
		# puts params[:answer][:content]
		@answer = Answer.create(:content => params[:answer][:content], :user_id => current_user.id, :question_id => params[:answer][:question_id].to_i) 
	end
end
