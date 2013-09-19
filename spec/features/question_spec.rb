require 'spec_helper'
include UserHelper

feature 'Create Question Form' do
	context "for signed in user" do
		it "should show a question form" do
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
				# u = User.create(handle: "handle",email: "test@test.com",password_digest: "password")
				sign_in
				visit new_question_path
				# save_and_open_page
				expect {
					fill_in 'question_title', with: 'Best Language?'
					fill_in 'question_content', with: "What's the best language?"
					click_button 'Create Question'
				}.to change(Question, :count).by(1)
			end
		end

		describe "on failure" do 
			it "should send back to question form" do
				visit new_question_path	
				fill_in 'content', with: "What's the best language?"
				click_button 'Create Question'
				page.should have_content "Error: Question Must Have Title"
			end
		end
	end
end