require 'spec_helper'
include UserHelper

feature 'Create Comment Form' do


	# All this tests need to be change to have a sign in user
	
	context "for signed in user" do
	    it "displays title create a comment" do
	      answer = Answer.create(content: 'this is an answer')
	      visit new_answer_comment_path(answer)
	      page.should have_content "Comment on this answer:"
	    end
	end

	context "for signed in user" do
	    it "creates a comment in the data base when submitting form" do
	      sign_in
	      question = Question.create(user_id: 1, title:'Question 1', content: 'This is a question')
	      answer = Answer.create(content: 'this is an answer', question_id: question.id)
	      visit new_answer_comment_path(answer)
	      expect {
					fill_in 'comment_content', with: "Test comment"
					click_button 'Create Comment'
				}.to change(Comment, :count).by(1)
	    end
	end

end

