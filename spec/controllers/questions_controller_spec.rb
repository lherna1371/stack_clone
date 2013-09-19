require 'spec_helper'
include QuestionHelper


describe QuestionsController do
	before(:each) do
		@qs = two_questions
	end

	describe "GET #index" do
		it "should route to questions_path" do
			get :index
			response.should render_template('index')
		end

		it "should assign @questions" do
			get :index
			expect(assigns(:questions)).to eq(@qs)
		end
	end

	describe "GET #show" do
		it "should route to question_path" do
			get :show, id: Question.all.first.id
			response.should render_template('show')
		end
		it "should show correct question" do
			@q = @qs.first
			get :show, id: @q.id
			expect(assigns(:question)).to eq(@q)
		end
	end

	describe "POST #create" do
		context "with valid attribs" do
			it "should create a new post" do
				@attr = {:title => 'Test', :content => 'Test2', :user_id => 1 }
				expect {
					Question.create(@attr)
				}.to change(Question, :count).by(1)
			end
		end

		context "with invalid attribs" do
			it "should not create a new post without title" do
				@attr = {:title => '', :content => 'Test2', :user_id => 1 }
				expect {
					Question.create(@attr)
				}.not_to change(Question, :count)
			end

			it "should not create a new post without content" do
				@attr = {:title => 'Test', :content => '', :user_id => 1 }
				expect {
					Question.create(@attr)
				}.not_to change(Question, :count)
			end

			it "should not create a new post without user" do
				@attr = {:title => 'Test', :content => 'Test2'}
				expect {
					Question.create(@attr)
				}.not_to change(Question, :count)
			end
		end
	end

	describe 'POST #destroy' do
		context 'as question author' do
			it "should delete a question" do
				@attr = {:title => 'Test', :content => 'Test2', :user_id => 1 }
				q = Question.create(@attr)
				expect {
					q.destroy
				}.to change(Question, :count).by(-1)
			end
		end

		context 'as a non-author' do
			it 'should not delete a question' do
				@attr = {:title => 'Test', :content => 'Test2', :user_id => 2 }
				q = Question.create(@attr)
				expect {
					delete :destroy
				}.not_to change(Question, :count)
			end
		end
	end
end