class QuestionsController < ApplicationController
	helper QuestionsHelper
	def index
		# @questions = Question.all
		flash[:error]
		@questions = Question.search(params[:search])
	end

	def new
		if current_user
			@question = Question.new
		else
			redirect_to login_path
		end
	end

	def edit

	end
		
	def show
		@answers = Answer.where(:question_id => [params[:id]])
		@question = Question.find(params[:id])

	end
	
	def create
		if current_user
			@question = Question.new(:title => params[:question][:title], :content => params[:question][:content], :user_id => params[:question][:user_id].to_i,up_votes: 0,down_votes: 0)
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

	def destroy
		@question = Question.find(params[:id])
		if @question.user_id == current_user.id
			@question.destroy
			redirect_to questions_path
		else
			@error = "You are not authorized to delete this question"
			redirect_to question_path(@question)
		end
	end

	def upvote
			question = Question.find(params[:format])
			question.up_votes += 1
			question.save
			redirect_to question_path(question)
	end

		def downvote
			question = Question.find(params[:format])
			question.down_votes -= 1
			question.save
			redirect_to question_path(question)
	end
end