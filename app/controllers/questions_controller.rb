class QuestionsController < ApplicationController

	def index
		@questions = Question.all
	end

	def new
		@question = Question.new
	end
	
	def show
		@question = Question.find(params[:id])
	end
	
	def create
		if current_user
			@question = Question.new(:title => params[:question][:title], :content => params[:question][:content], :user_id => params[:question][:user_id].to_i)
			if @question.title.nil?
				@error = "Error: Question Must Have Title"
				render new_question_path
			elsif @question.content.nil?
				@error = "Error: Question Must Have Content"
			else
				if @question.save
					redirect_to @question
				else
					@error = "Error: Question was not saved"
					render new_question_path
				end
			end
		else
			redirect_to login_path
		end
	end
end