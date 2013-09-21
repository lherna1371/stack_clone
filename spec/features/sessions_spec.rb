require 'spec_helper'

describe "Sessions" do
	it "should be able to log in a user that is active" do
		u = User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation=> "abc123")

		visit ('/login')
		fill_in 'session_handle', with: 'Test1'
		fill_in 'session_password', with: "abc123"

		click_button 'Login'

		current_path.should == questions_path
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

	it "should not be able to login a user that is deactivated" do
		a = User.create!(handle: "handle",email: "test@test.com",password: "password", password_confirmation: "password",is_active: false)
  	visit login_path
  	fill_in 'session_handle', with: "handle"
  	fill_in 'session_password', with: "password"
  	click_button 'Login'
  	current_path.should eq sessions_path
  	page.should have_content "Your account is not active"
	end
end