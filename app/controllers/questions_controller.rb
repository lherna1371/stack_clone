class QuestionsController < ApplicationController
	helper QuestionsHelper
	def index
		# @questions = Question.all
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
		@question = Question.find(params[:id])
		if @question.user_id == current_user.id || current_user.admin
			render :edit
		else
			flash.now[:error] = "You do not have access to edit"
			redirect_to @question
		end
	end
	
	def update
		@question = Question.find(params[:id])
		@question.update_attributes(question_attributes)
		redirect_to @question
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
			flash.now[:error] = "You are not authorized to delete this question"
			redirect_to question_path(@question)
		end
	end

	def upvote
		if current_user
			question = Question.find(params[:format])
			question.upvote_questions.create(:user_id => current_user.id)
		end
		redirect_to question_path(question)
	end

	def downvote
		if current_user
			question = Question.find(params[:format])
			question.downvote_questions.create(:user_id => current_user.id)
		end
		redirect_to question_path(question)
	end


	def favorite
		@question = Question.find(params[:id])
	    type = params[:type]
	    if type == "favorite"
	      current_user.favorites << @question
	      redirect_to :back, notice: 'You favorited #{@question.name}'

	    elsif type == "unfavorite"
	      current_user.favorites.delete(@question)
	      redirect_to :back, notice: 'Unfavorited #{@question.name}'

	    else
	      redirect_to :back, notice: 'Nothing happened.'
	    end
  	end

  private

  def question_attributes
  	params.require(:question).permit(:title, :content)
  end
end