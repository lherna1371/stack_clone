class QuestionsController < ApplicationController
	def new
		@question = Question.new
	end

	def create
		if true #current_user
			@question = Question.new(:params)
			
		else
			#redirect to user sign up
		end
	end
end