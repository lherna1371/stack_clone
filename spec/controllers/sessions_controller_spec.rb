require 'spec_helper'

describe SessionsController do
	it "should be able to log in a user" do
		User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation=> "abc123")
		visit ('/login')
			expect {
					fill_in 'session_handle', with: 'Test1'
					fill_in 'session_password', with: "abc123"
					click_button 'login'
				}.to eq 100 
	end

	it "should be able to log out a user" do
		pending
	end
end