require 'spec_helper'

describe CommentsController do

	context 'when commenting on an answer' do
		it 'loads the answer to post the comment to' do
			# get :new
			answer_moc = double(:answer, :id => 1)
			
			get new_answer_comment_path(answer_moc.id) 
			Answer.should_receive(:find).with(answer_moc.id).and_return answer_moc

			# assigns(:resource).should == answer_moc
		end


		it 'redirects to questions' 
	end

end