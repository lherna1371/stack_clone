class QuestionsController < ApplicationController

	def index
		@questions = Question.all
	end

	def new
		if current_user
			@question = Question.new
		else
			redirect_to login_path
		end
	end
	
	def show
		@question = Question.find(params[:id])
	end
	
	def create
		if current_user
			@question = Question.new(:title => params[:question][:title], :content => params[:question][:content], :user_id => params[:question][:user_id].to_i)
			if @question.title == ''
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

	def delete
		@question = Question.find(params[:question_id].to_i)
		if @question.user.id == current_user.id
			@question.destroy
			redirect_to questions_path
		else
			@error = "You are not authorized to delete this question"
			redirect_to question_path(@question)
		end
	end
end