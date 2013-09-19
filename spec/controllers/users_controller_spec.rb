require 'spec_helper'

feature UsersController do
	describe "GET index" do
		it "should be able to get the user index" do
			User.create(handle: "handle",email: "test@test.com",password_digest: "password")
			@users = User.all
			get :index

			expect(assigns(:users)).to eq(@users)
		end
	end

	describe "Create User" do
		before(:each) do
  		@attr = { 
	  		:handle => "Example", 
	  		:email => "user@example.com",
	  		:password => "foobar",
	  		:password_confirmation => "foobar"
	  	}
	  end

	 	it "should create a new instance given valid attributes" do
	  	 expect { User.create!(@attr) }.to change(User, :count).by(1)
	  end
	end

	describe "should be able to find user for show" do
		it "will be able to send the params for the user for profile page" do
			user = double(:user, :id => "1", :handle => "test", :password_digest => "test")
      User.should_receive(:find).with(user.id).and_return user
      get :show, :id => user.id
		end
	end
end