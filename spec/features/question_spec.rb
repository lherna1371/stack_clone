require 'spec_helper'
include UserHelper

feature 'Create Question Form' do
	context "for signed in user" do
		it "should show a question form" do
			sign_in
			visit new_question_path
			page.should have_content "Ask a Question"
		end
	end

	context "for unsigned-in user" do
		it "should redirect to sign in page" do
			visit new_question_path
			page.should_not have_content "Ask a Question"
		end
	end
end

feature 'Submit Question' do
	context "for signed in user" do
		describe "on success" do 
			it "should save to database" do
				sign_in
				visit new_question_path
				expect {
					fill_in 'question_title', with: 'Best Language?'
					fill_in 'question_content', with: "What's the best language?"
					click_button 'Create Question'
				}.to change(Question, :count).by(1)
			end
		end

		describe "on failure" do 
			it "should send back to question form" do
				sign_in
				visit new_question_path	
				fill_in 'question_content', with: "What's the best language?"
				click_button 'Create Question'
				page.should have_content "Error: Question Must Have Title"
			end
		end
	end
end

feature 'View Question' do
	context 'concerning delete button' do
		it 'should be visible if user wrote question' do
			sign_in
			new_question
			page.should have_button "Delete"
		end

		it 'should be invisible if user is not author' do
			qs = two_questions
			sign_in
			visit question_path(qs.first)
			page.should_not have_button "Delete"
		end
	end
end

feature 'Search Bar' do
	it 'should return match based on input' do
		Question.create(:user_id => 1, title: "sample question one", :content => "hey there dude")
		Question.create(:user_id => 1, title: "sample question two", :content => "wazzup")

		sign_in
		visit questions_path
		fill_in 'search', with: "dude"
		click_button 'Search'

		page.should have_content "sample question one"
		page.should_not have_content "sample question two"
	end 
end

feature 'Edit Question' do
	context "As Admin" do
		before(:each) do
			sign_in_admin
			click_link 'All user questions'
			page.should have_content "TestQ"
			click_link 'TestQ'
			click_link 'Edit'
			page.should have_content 'Edit Question'
		end

		it "should be able to edit other users' Question Title" do
			fill_in 'question_title', with: 'TestR'
			click_button 'Update Question'
			page.should have_content 'TestR'
		end

		it "should be able to edit other users' Question Content" do
			fill_in 'question_content', with: 'Content After'
			click_button 'Update Question'
			page.should have_content 'Content After'
		end
	end

	context "as question owner" do
		before(:each) do
			sign_in
			click_link 'Profile'
			click_link 'All user questions'
			page.should have_content "TestQ"
			click_link 'TestQ'
			click_link 'Edit'
			page.should have_content 'Edit Question'
		end

		it "should be able to edit Question Title" do
			fill_in 'question_title', with: 'TestR'
			click_button 'Update Question'
			page.should have_content 'TestR'
		end

		it "should be able to edit Question Content" do
			fill_in 'question_content', with: 'Content After'
			click_button 'Update Question'
			page.should have_content 'Content After'
		end
	end
end














