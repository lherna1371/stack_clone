class QuestionsController < ApplicationController
	helper QuestionsHelper
	def index
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
		@array = [ ]
		# puts "**************************************************"
		# puts params[:id]
		@answers = Answer.where(:question_id => [params[:id]])
		@question = Question.find(params[:id])
		@question_comments = @question.comments
		@qt = QuestionTag.where(:question_id => [params[:id]])
		# puts @qt
		@qt.each do |t|
			@array << t.tag_id
		end 
		# puts @array.inspect
		# puts @qt.first.inspect
		# @n = @qt.first.tag_id
		# @tag = Tag.where(:id => @n)
	end
	
	def create
		if current_user
			@question = Question.new(:title => params[:question][:title], :content => params[:question][:content], :user_id => params[:question][:user_id].to_i,up_votes: 0,down_votes: 0)
			# @tag = Tag.new(:tag_name => params[:question][:tag][:tag_name])
			@tag = params[:question][:tag][:tag_name]
			tsplit = @tag.split
			if @question.title == ''
				@error = "Error: Question Must Have Title"
				render new_question_path
			elsif @question.content.nil?
				@error = "Error: Question Must Have Content"
			else
				if @question.save
					tsplit.each do |tag|
						@newtag = Tag.new(:tag_name => tag)
						@newtag.save
						QuestionTag.create(:tag_id => @newtag.id, :question_id => @question.id)
					end 
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
		if current_user && (@question.user_id == current_user.id || current_user.admin)
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
			if question.downvote_questions.where(:user_id => current_user.id).empty? 
				if question.upvote_questions.where(:user_id => current_user.id).empty?
					UpvoteQuestion.create(:user_id => current_user.id, :question_id => question.id)
				end
			else
				question.downvote_questions.where(:user_id => current_user.id).first.destroy
			end
		end
		redirect_to question_path(question)
	end

	def downvote
		if current_user
			question = Question.find(params[:format])
			if question.upvote_questions.where(:user_id => current_user.id).empty?
				if question.downvote_questions.where(:user_id => current_user.id).empty?
					DownvoteQuestion.create(:user_id => current_user.id, :question_id => question.id)
				end
			else
				question.upvote_questions.where(:user_id => current_user.id).first.destroy
			end
		end
		redirect_to question_path(question)
	end


	def favorite
		@question = Question.find(params[:id])
	    type = params[:type]
	    if type == "favorite"
	      current_user.favorites << @question
	      redirect_to :back, notice: "You favorited '#{@question.title}'"
	    elsif type == "unfavorite"
	      current_user.favorites.delete(@question)
	      redirect_to :back, notice: "Unfavorited '#{@question.title}'"

	    else
	      redirect_to :back, notice: 'Nothing happened.'
	    end
  	end

  private

  def question_attributes
  	params.require(:question).permit(:title, :content)
  end
end