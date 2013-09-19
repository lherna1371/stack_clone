require 'spec_helper'
include UserHelper
include QuestionHelper

feature QuestionsController do
	describe "GET #index" do
		#u = User.create(handle: "handle",email: "test@test.com",password_digest: "password")
		#controller.stub.current_user = u
		Question.create!(:user_id => 1, :title => 'Test1', :content => 'content 1')
    Question.create!(:user_id => 1, :title => 'Test2', :content => 'content 2')
		get :index
		response.should redirect_to new_post_path
	end
end