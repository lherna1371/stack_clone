require 'spec_helper'

describe CommentsController do

	context 'when commenting on an answer' do
		
		let(:answer) { double(:answer, id: 1)}

		context 'GET to new' do
			before do 
				expect(Answer).to receive(:find).with(answer.id.to_s).and_return(answer)
				get :new, answer_id: answer.id
			end

			it 'loads the answer to send the comment post' do
				expect(assigns(:resource)).to eq answer
			end	

			it 'renders the new view' do
				expect(response).to render_template :new
			end
		end

		context 'POST to create' do

			let(:user) { double(:user, id: 1) }
			let(:answer) { double(:answer, id: 1)}
			let(:question) {double(:question, id: 1)}
			let(:comment) {Comment.new}
			let(:comments) {double(:comments, create: comment)}
			# let(:comments) {double(:comments, create: comment)}
			let(:id) { "1" }

			# let(:user) { double(:user, id: 1) }
			# let(:question) {Question.new}
			# let(:answer) { Answer.new(question_id: question.id)}
			# let(:comment) {Comment.new}
			# let(:comments) {double(create: comment)}
			# let(:id) { "1" }

			it 'redirects to question show' do

				expect(Answer).to receive(:find).with(id).and_return(answer)
				expect(answer).to receive(:question).and_return(question)
				expect(controller).to receive(:current_user).and_return(user)
				expect(answer).to receive(:comments).and_return(comments)

				post :create, answer_id: id, :comment => { content: "some text" }

				expect(response).to redirect_to question
			end
		end
	end
end