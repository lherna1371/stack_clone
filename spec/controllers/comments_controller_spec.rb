require 'spec_helper'

describe CommentsController do

	  	context 'when commenting on an answer' do
		it 'loads the answer to post the comment to' do
			answer_moc = double(:answer, :id => 1)
			Answer.should_receive(:find).with(answer_moc.id).and_return answer_moc

			get new_answer_comment_path(answer_moc) 

			assigns(:resource).should == answer_moc

		end
	end

end