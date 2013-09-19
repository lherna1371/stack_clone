require 'spec_helper'

describe CommentsController do
  

  describe "new view" do
    it "displays title create a comment" do
      visit new_answer_comment
      page.should have_content "Comment on this answer:"
    end

  end
end