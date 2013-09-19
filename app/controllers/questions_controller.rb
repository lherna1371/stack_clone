class QuestionsController < ApplicationController
	def new
		@question = Question.new
	end

	def create
		if true #current_user
			@question = Question.new(params[:question])
			if @question.title.nil?
				@error = "Error: Question Must Have Title"
				render new_question_path
			elsif @question.content.nil?
				@error = "Error: Question Must Have Content"
			else
				if @question.save?
					redirect @question
				else
					@error = "Error: Question was not saved"
					render new_question_path
				end
			end
		else
			#redirect to user sign up
		end
	end
end