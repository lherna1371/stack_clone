require 'spec_helper'

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
				visit new_question_path
				expect {
					fill_in 'question_title', with: 'Best Language?'
					fill_in 'question_content', with: "What's the best language?"
					click_button 'Create Question'
				}.to change(Question, count).by(1)
			end
		end

		describe "on failure" do 
			it "should send back to question form" do
				visit new_question_path	
				fill_in 'question_content', with: "What's the best language?"
				click_button 'Create Question'
				page.should have_content "Error: Question Must Have Title"
			end
		end
	end

	context "for unsigned-in user" do
		it "should redirect to sign in path" do
			pending
			page.should have_content "Sign In"
		end
	end
end