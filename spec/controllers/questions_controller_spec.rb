require 'spec_helper'

feature QuestionsController do
	describe "GET #index" do
		get :index
		response.should redirect_to new_post_path
	end
end