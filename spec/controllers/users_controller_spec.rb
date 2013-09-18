require 'spec_helper'

describe UsersController do
	describe "GET index" do
		it "should be able to get the user index" do
			User.create(handle: "handle",email: "test@test.com",password_digest: "password")
			@users = User.all
			get :index

			expect(assigns(:users)).to eq(@users)
		end
	end

	describe "Post create" do
		it "should be able to create a new user" do
				pending
		end
	end
end