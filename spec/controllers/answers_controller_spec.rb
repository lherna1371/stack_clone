require 'spec_helper'

describe AnswersController do

describe "Answer is saved to database and database is +1" do
		it "should save question to databse and increase count by one" do
		question = Answer.create(content: "sample answer response", question_id: 1, user_id: 1, up_votes: 0, down_votes: 0)
		change(Answer, :count).by(1)
		end
	end
end