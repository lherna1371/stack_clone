require 'spec_helper'

describe "Sessions" do
	it "should be able to log in a user" do
		User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation=> "abc123")

		visit ('/login')
		fill_in 'session_handle', with: 'Test1'
		fill_in 'session_password', with: "abc123"

		click_button 'Login'

		current_path.should == users_path
	end

	it "should be able to log out a user" do
		User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation=> "abc123")

		visit ('/login')
		fill_in 'session_handle', with: 'Test1'
		fill_in 'session_password', with: "abc123"

		click_button 'Login'

		click_link('Logout')

		current_path.should eq root_path
	end
end