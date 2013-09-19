require 'spec_helper'

describe SessionsController do
	describe "#create" do
		before(:each) do
			@user = User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation=> "abc123")
		end
		it "should be able to create a session" do
			post :create,{session: {handle: 'Test1', password: 'abc123'}}
			session[:user_id].should eq @user.id
		end

		it "should redirect you to root and keep session nil if incorrect info" do
			post :create,{session: {handle: 'Test1', password: 'ab123'}}
			session[:user_id].should eq nil
			response.should redirect_to(root_path)
		end
	end

	describe "#destroy" do
		before(:each) do 
			session[:user_id] = 1
		end

		it "should be able to clear session on logout" do
			get :destroy
			session[:user_id].should eq nil
		end
end
end