class AnswersController < ApplicationController

	def create
		puts params
		@answer = Answer.new(:content => params[:content], :user_id => 1, :question_id => params[:question_id])
		@answer.save 
		# current_user has not been implemented?
		# redirect_to question page or answer confirmation page?
	end
end
