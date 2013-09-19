require 'spec_helper'

feature 'Create Comment Form' do
	
	context "for signed in user" do
	    it "displays title create a comment" do
	      answer = Answer.create(content: 'this is an answer')
	      visit new_answer_comment_path(answer)
	      page.should have_content "Comment on this answer:"
	    end
	end
end

