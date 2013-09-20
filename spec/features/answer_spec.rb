require 'spec_helper'
include UserHelper

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


