require 'spec_helper'
include QuestionHelper


describe QuestionsController do
	describe "GET #index" do

		before(:each) do
			@qs = two_questions
		end

		it "should route to questions_path" do
			get :index
			response.should render_template('index')
		end

		it "should assign @questions" do
			get :index
			expect(assigns(:questions)).to eq(@qs)
		end
	end
end