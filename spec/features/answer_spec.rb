require 'spec_helper'
include UserHelper
include AnswerHelper

describe "Answer Question" do
	it "should have content within content input box" do
	question = Question.create(title: "sample title", content: "Hey, this should be content", user_id: 1,:up_votes => 0, :down_votes => 0)
	visit question_path(question)
	page.should have_content "Answer Question:" 
	end
end

describe "Answer is saved to database and database is +1" do
	it "should save question to databse and increase count by one" do
		sign_in
		question = Question.create(title: "sample title", content: "Hey, this should be content", user_id: 1,:up_votes => 0, :down_votes => 0)
		visit question_path(question)		
		fill_in 'answer_content', with: 'Sample Answer'
		click_button 'Save Answer'
		current_path.should == question_path(question.id)
	end
end

feature 'Editing Answer' do
	context 'As Admin' do
		before(:each) do
			basic_setup
			sign_in_admin
			visit question_path(Question.first)
		end
		
		it 'should be able to navigate to Edit Link' do
			page.should have_content 'Edit Answer'
		end

		it "should be able to edit content" do
			click_link 'Edit Answer'
			fill_in 'answer_content', with: 'Edited'
			click_button 'Update Answer'
			page.should have_content 'Edited'
		end
	end

	context 'As Answerer' do
		it "should update a question" do
			basic_setup
			visit login_path
			fill_in 'session_handle', with: 'handle2'
			fill_in 'session_password', with: 'password'
			click_button 'Login'
			click_link 'Handle2'
			click_link 'All user answers'
			click_link 'User 1 Title'
			page.should have_content 'Edit Answer'
			click_link 'Edit Answer'
			fill_in 'answer_content', with: 'Updated Answer'
			click_button 'Update Answer'
			page.should have_content 'Updated Answer'
		end
	end

	context "As Restricted User" do
		it "should not see Edit Link" do
			basic_setup
			visit login_path
			fill_in 'session_handle', with: 'handle4'
			fill_in 'session_password', with: 'password'
			visit questions_path
			click_link 'User 1 Title'
			page.should_not have_content 'Edit Answer'
		end
	end

	context "When Not Signed In" do
		it "should not see Edit Link" do
			basic_setup
			visit questions_path
			click_link 'User 1 Title'
			page.should_not have_content 'Edit Answer'
		end
	end
end

