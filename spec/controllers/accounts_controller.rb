require 'spec_helper'

describe AccountsController do

	it "should be able to deactive a user" do
		@user = User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation=> "abc123",is_active: true)
		post :update,{format: "#{@user.id}"}
		response.should redirect_to(questions_path)
	end
	
	it "should be able to re-active a user" do
		@user = User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation=> "abc123",is_active: false)
		post :update,{format: "#{@user.id}"}
		response.should redirect_to(login_path)
	end

end

