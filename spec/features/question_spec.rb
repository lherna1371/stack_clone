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
		it "should save to database" do
			visit new_question_path
			expect {
				fill_in 'question_title', with: 'Best Language?'
				fill_in 'question_content', with: "What's the best language?"
				click_button 'Create Question'
			}.to change(Question, count).by(1)
		end
	end

	context "for unsigned-in user" do
		pending
		it "should redirect to sign in path"
	end
end