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
			page.should have_button "Delete Question"
		end

		it 'should be visible if user is admin' do
			sign_in_admin
			click_link 'All user questions'
			click_link 'TestQ'
			page.should have_button "Delete Question"
		end

		it 'should be invisible if user is not author' do
			qs = two_questions
			sign_in
			visit question_path(qs.last)
			page.should_not have_button "Delete Question"
		end

		it 'should be invisible if user a viewer' do
			qs = two_questions
			visit question_path(qs.last)
			page.should_not have_button "Delete Question"
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

	context "as Question Owner" do
		before(:each) do
			sign_in
			click_link 'Handle'
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

	context "As Non-Admin/Non-Author Signed In User" do
		before(:each) do
			two_users
			click_link 'All user questions'
			click_link 'TestQ'
		end

		it "should not be able to see edit link on other users' questions" do
			page.should_not have_content "Edit"
		end
	end
end

feature 'Voting' do
	describe 'Upvotes' do
		context 'ability' do
			it "should be allowed for signed in users" do
				sign_in
				click_link 'TestQ'
				expect {page.find('#upvote_q').click}.to change(UpvoteQuestion, :count).by(1)
			end

			it "should not allow multiple upvotes" do
				sign_in
				click_link 'TestQ'
				expect {page.find('#upvote_q').click}.to change(UpvoteQuestion, :count).by(1)
				expect {page.find('#upvote_q').click}.not_to change(UpvoteQuestion, :count)
			end

			it "should not be allowed for unsigned in users" do
				two_questions
				visit questions_path
				click_link 'Test1'
				expect {page.find('#upvote_q').click}.not_to change(UpvoteQuestion, :count)
			end
		end
	end

	describe 'Downvotes' do
		context 'ability' do
			it "should be allowed for signed in users" do
				sign_in
				click_link 'TestQ'
				expect {page.find('#downvote_q').click}.to change(DownvoteQuestion, :count).by(1)
			end

			it "should not allow multiple downvotes" do
				sign_in
				click_link 'TestQ'
				expect {page.find('#downvote_q').click}.to change(DownvoteQuestion, :count).by(1)
				expect {page.find('#downvote_q').click}.not_to change(DownvoteQuestion, :count)
			end

			it "should not be allowed for unsigned in users" do
				two_questions
				visit questions_path
				click_link 'Test1'
				expect {page.find('#downvote_q').click}.not_to change(DownvoteQuestion, :count)
			end
		end
	end

	describe 'Cancelling Votes' do
		it 'Clicking Upvote should cancel a Downvote if previously clicked' do
			sign_in
			click_link 'TestQ'
			expect {page.find('#downvote_q').click}.to change(DownvoteQuestion, :count).by(1)
			expect {page.find('#upvote_q').click}.to change(DownvoteQuestion, :count).by(-1)
		end

		it 'Clicking Downvote should cancel an Upvote if previously clicked' do
			sign_in
			click_link 'TestQ'
			expect {page.find('#upvote_q').click}.to change(UpvoteQuestion, :count).by(1)
			expect {page.find('#downvote_q').click}.to change(UpvoteQuestion, :count).by(-1)
		end
	end
end
