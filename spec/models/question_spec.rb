require 'spec_helper'

describe Question do
	context "with invalid attributes" do
		it "is invalid without a title" do 
			q = Question.new(:user_id => 1, :content => "hey",:up_votes => 0, :down_votes => 0)
			q.save
			q.should_not be_valid
		end

		it "is invalid without content" do 
			q = Question.new(:user_id => 1, :title => "hey",:up_votes => 0, :down_votes => 0)
			q.save
			q.should_not be_valid
		end

		it "is invalid without a user" do 
			q = Question.new(:title => "yo", :content => "hey",:up_votes => 0, :down_votes => 0)
			q.save
			q.should_not be_valid
		end
	end

	describe ".search" do

		let!(:question) { Question.create(:user_id => 1, title: "sample question one", :content => "hey there dude",:up_votes => 0, :down_votes => 0) }

		context "works for exact matches" do
			it "on content" do
				Question.search("hey there dude").should eq([question])
			end 

			it "on title" do
				Question.search("sample question one").should eq([question])
			end 
		end

		context "works for partial matches starting with search term" do
			it "on content" do
				Question.search("hey").should eq([question])
			end 

			it "on title" do
				Question.search("sample").should eq([question])
			end 
		end

		context "works for partial matches ending with search term" do
			it "on content" do
				Question.search("dude").should eq([question])
			end 

			it "on title" do
				Question.search("one").should eq([question])
			end 
		end

		context "works for partial matches inside with search term" do
			it "on content" do
				Question.search("there").should eq([question])
			end 

			it "on title" do
				Question.search("question").should eq([question])
			end 
		end

		it "should return an empty array if no matches" do
			Question.search("not found").should eq([ ])
		end 

		it "should strip spaces off search term" do
			Question.search("   question    ").should eq([question])
		end
	end		


end