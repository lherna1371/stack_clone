require 'spec_helper'
include QuestionHelper

describe QuestionsController do
	before(:each) do
		@qs = two_questions
	end
	
	describe 'GET #edit' do
		context 'as admin' do
			it "should route to the correct page" do
				admin = double(:user, :admin => true, :id => 2)
				controller.stub(:current_user).and_return admin
				question = double(:question, :user_id => 1, :title => 'Title', :content => 'Content Now', :id => 1)
				controller.stub(:question).and_return question
				
				get :edit, id: @qs.first.id
				response.status.should eq 200
			end
		end

		context 'as author' do
			it "should route to the correct page" do
				author = double(:user, :id => 1, :admin => false)
				controller.stub(:current_user).and_return author
				q = Question.create(:user_id => 1, :title => "Title", :content => 'OK')
				get :edit, id: q.id
				response.status.should eq 200
			end
		end

		context 'as non-author/non-admin' do
			it "should not route to the edit page" do
				question = double(:question, :user_id => 1, :title => 'Title', :content => 'Content Now', :id => 1)
				current_user = double(:user, :admin => false, :id => 2)
				
				controller.stub(:question).and_return question
				controller.stub(:current_user).and_return current_user
				
				get :edit, id: @qs.last.id
				response.should_not render_template 'edit'
			end
		end
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

		it "should only assign questions that match search" do
			get :index, search: "Test2"
			expect(assigns(:questions)).to eq([@qs.last])
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
				@attr = {:title => 'Test', :content => 'Test2', :user_id => 1, :up_votes => 0, :down_votes => 0 }
				expect {
					Question.create(@attr)
				}.to change(Question, :count).by(1)
			end
		end

		context "with invalid attribs" do
			it "should not create a new post without title" do
				@attr = {:title => '', :content => 'Test2', :user_id => 1,:up_votes => 0, :down_votes => 0  }
				expect {
					Question.create(@attr)
				}.not_to change(Question, :count)
			end

			it "should not create a new post without content" do
				@attr = {:title => 'Test', :content => '', :user_id => 1,:up_votes => 0, :down_votes => 0  }
				expect {
					Question.create(@attr)
				}.not_to change(Question, :count)
			end

			it "should not create a new post without user" do
				@attr = {:title => 'Test', :content => 'Test2',:up_votes => 0, :down_votes => 0 }
				expect {
					Question.create(@attr)
				}.not_to change(Question, :count)
			end
		end
	end

	describe 'POST #destroy' do
		before(:each) do
			controller.stub(:current_user).and_return(double(:user, :id => 1))
		end

		context 'as question author' do
			it "should delete a question" do
				@attr = {:title => 'Test', :content => 'Test2', :user_id => 1,:up_votes => 0, :down_votes => 0  }
				q = Question.create!(@attr)
				expect {
					delete :destroy, id: q.id
				}.to change(Question, :count).by(-1)
			end
		end

		context 'as a non-author' do
			it 'should not delete a question' do
				@attr = {:title => 'Test', :content => 'Test2', :user_id => 2,:up_votes => 0, :down_votes => 0  }
				q = Question.create(@attr)
				expect {
					delete :destroy, id: q.id
				}.not_to change(Question, :count)
			end
		end

		context 'as Admin' do
			it "should delete a question" do
				current_user = double(:user, :admin => true)
				controller.stub(:current_user).and_return current_user
				@attr = {:title => 'Test', :content => 'Test2', :user_id => 1,:up_votes => 0, :down_votes => 0  }
				q = Question.create!(@attr)
				expect {
					delete :destroy, id: q.id
				}.to change(Question, :count).by(-1)
			end
		end
	end

	describe 'POST #favorite' do
		context 'can be saved to favorites' do
			it 'should save if type equalls favorite' do
				user = User.create(handle: "handle",email: "test@test.com",password_digest: "password")
				q = Question.create(:title => 'Test', :content => 'Test2', :user_id => 1,:up_votes => 0, :down_votes => 0)
	    		type = "favorite"
	    		expect user.favorites << q
			end  
		end 

		context 'should delete from favorites' do
			it 'should not delete from favorites if type equalls Unfavorited' do
				user = User.create(handle: "handle",email: "test@test.com",password_digest: "password")
				q = Question.create(:title => 'Test', :content => 'Test2', :user_id => 1,:up_votes => 0, :down_votes => 0)
	    		type = "Unfavorited"
	    		expect user.favorites.delete(q)
			end  
		end 
	end 
end

