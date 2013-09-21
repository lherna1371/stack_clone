require 'spec_helper'

describe CommentsController do

	context 'when commenting on an answer' do
		
		let(:user) { double(:user, id: 1) }
		let(:question) {Question.new}
		let(:answer) { double(:answer, id: 1)}
		let(:comment) {Comment.new}
		let(:create) {double(create: comment)}
		let(:id) { "1" }

		before do
			expect(Answer).to receive(:find).with(id).and_return(answer)
		end

		context 'GET to new' do
			before do 
				
				get :new, answer_id: id
			end

			it 'loads the answer to send the comment post' do
				expect(assigns(:resource)).to eq answer
			end	

			it 'renders the new view' do
				expect(response).to render_template :new
			end
		end

		context 'POST to create' do

			before do
				expect(controller).to receive(:current_user).and_return(user)
				expect(answer).to receive(:question).and_return(question)
				expect(answer).to receive(:comments).and_return(create)

				post :create, answer_id: id, :comment => { content: "some text" }
			end

			it 'redirects to question show' do
				expect(response).to redirect_to question
			end
		end
	end

	context 'when commenting on an question' do
		
		let(:user) { double(:user, id: 1) }
		let(:question) {Question.new}
		let(:answer) { double(:answer, id: 1)}
		let(:comment) {Comment.new}
		let(:create) {double(create: comment)}
		let(:id) { "1" }

		before do
			expect(Question).to receive(:find).with(id).and_return(question)
		end

		context 'GET to new' do
			before do 
				
				get :new, question_id: id
			end

			it 'loads the answer to send the comment post' do
				expect(assigns(:resource)).to eq question
			end	

			it 'renders the new view' do
				expect(response).to render_template :new
			end
		end

		context 'POST to create' do

			before do
				expect(controller).to receive(:current_user).and_return(user)
				expect(question).to receive(:comments).and_return(create)

				post :create, question_id: id, :comment => { content: "some text" }
			end

			it 'redirects to question show' do
				expect(response).to redirect_to question
			end
		end
	end

	context 'when content is blank' do


		context 'when commenting in a answer' do

			let(:answer) { double(:answer, id: 1)}
			let(:id) { "1" }

			before(:each) do
				request.env["HTTP_REFERER"] = new_answer_comment_path(answer)
				end

			it 'redirects back' do
				post :create, answer_id: id, :comment => { content: " " }
				
				# expect(response).to redirect_to :back
				# expect(response).to render_template :new
				expect(response).to redirect_to new_answer_comment_path(answer)
			end	
		end

		context 'when commenting in a question' do

			let(:question) { double(:question, id: 1)}
			let(:id) { "1" }

			before(:each) do
				request.env["HTTP_REFERER"] = new_question_comment_path(question)
				end

			it 'redirects back' do
				post :create, question_id: id, :comment => { content: " " }
				
				# expect(response).to redirect_to :back
				# expect(response).to render_template :new
				expect(response).to redirect_to new_question_comment_path(question)
			end	
		end
	end
end


