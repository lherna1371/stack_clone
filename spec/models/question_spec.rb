require 'spec_helper'

describe Question do
	context "with invalid attributes" do
		it "is invalid without a title" do 
			q = Question.new(:user_id => 1, :content => "hey")
			q.save
			q.should_not be_valid
		end

		it "is invalid without content" do 
			q = Question.new(:user_id => 1, :title => "hey")
			q.save
			q.should_not be_valid
		end

		it "is invalid without a user" do 
			q = Question.new(:title => "yo", :content => "hey")
			q.save
			q.should_not be_valid
		end
	end
end