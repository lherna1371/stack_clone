require 'spec_helper'

describe AnswersController do

	describe "Answer is saved to database and database is +1" do
		it "should save question to databse and increase count by one" do
			question = Answer.create(content: "sample answer response", question_id: 1, user_id: 1, up_votes: 0, down_votes: 0)
			change(Answer, :count).by(1)
		end
	end

	describe 'GET #edit' do
		before(:each) do
			@answer = Answer.create(:user_id => 1, :content => 'Content Now')
		end

		context 'as admin' do
			it "should route to the correct page" do
				admin = double(:user, :admin => true)
				controller.stub(:current_user).and_return admin
				get :edit, id: @answer.id
				response.status.should eq 200
			end
		end

		context 'as author' do
			it "should route to the correct page" do
				author = double(:user, :id => 1, :admin => false)
				controller.stub(:current_user).and_return author
				get :edit, id: @answer.id
				response.status.should eq 200
			end
		end

		context 'as non-logged-in' do
			it "should not route to the edit page" do
				get :edit, id: @answer.id
				response.status.should eq 302
			end
		end

		context 'as non-author/non-admin' do
			it "should not route to the edit page" do
				viewer = double(:user, :admin => false, :id => 2)
				controller.stub(:current_user).and_return viewer
				get :edit, id: @answer.id
				response.status.should eq 302
			end
		end
	end

	describe 'POST update' do
		before(:each) do
			q = Question.create(:user_id => 15, :title => 'Title', :content => 'Content')
			@answer = q.answers.create(:user_id => 1, :content => 'Content Now')
			@attr = {:content => 'Content Updated'}
		end

		context 'As Admin' do
			it 'should allow update' do
				current_user = double(:user, :admin => true, :id => 10)
				controller.stub(:current_user).and_return current_user
				put :update, :id => @answer.id, :answer => @attr
				@answer.reload
				@answer.content.should == @attr[:content]
			end
		end

		context 'As Author' do
			it 'should allow update' do
				current_user = double(:user, :admin => false, :id => 1)
				controller.stub(:current_user).and_return current_user
				put :update, :id => @answer.id, :answer => @attr
				@answer.reload
				@answer.content.should == @attr[:content]
			end
		end

		context 'As Restricted User' do
			it 'should not allow update' do
				current_user = double(:user, :admin => false, :id => 10)
				controller.stub(:current_user).and_return current_user
				put :update, :id => @answer.id, :answer => @attr
				@answer.reload
				@answer.content.should_not == @attr[:content]
			end
		end

		context 'As Viewer' do
			it 'should not allow update' do
				put :update, :id => @answer.id, :answer => @attr
				@answer.reload
				@answer.content.should_not == @attr[:content]
			end
		end
	end
end