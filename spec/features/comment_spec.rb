require 'spec_helper'
include UserHelper

feature 'Create Comment form' do
	let(:answer) { Answer.create(content: 'this is an answer', question_id: question.id)}
	let(:question) { Question.create(user_id: 1, title:'Question 1', content: 'This is a question') }
	
	context "commenting on an answer" do

	    it "displays title for answer" do
	      visit new_answer_comment_path(answer)
	      page.should have_content "Comment on this answer:"
	    end


	    it "creates a comment in the data base when submitting form" do
	      sign_in
	      visit new_answer_comment_path(answer)
	      expect {
					fill_in 'comment_content', with: "Test comment"
					click_button 'Create Comment'
				}.to change(Comment, :count).by(1)
	    end
	end

	context "commenting on an question" do

	    it "displays title for question" do
	      visit new_question_comment_path(question)
	      page.should have_content "Comment on this question:"
	    end


	    it "creates a comment in the data base when submitting form" do
	      sign_in
	      visit new_question_comment_path(question)
	      expect {
					fill_in 'comment_content', with: "Test comment"
					click_button 'Create Comment'
				}.to change(Comment, :count).by(1)
	    end
	end



end

