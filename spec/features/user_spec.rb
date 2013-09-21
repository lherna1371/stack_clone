require 'spec_helper'
include UserHelper

feature 'Create User Form' do
	it "should show a user create form" do
		visit new_user_path
		page.should have_content "Handle"
	end
end

feature 'Create User' do
	it "should save to database" do
		visit new_user_path
		expect {
			fill_in 'user_handle', with: 'username'
			fill_in 'user_email', with: "email@email.com"
			fill_in 'user_password', with: "password"
			fill_in 'user_password_confirmation', with: "password"
			click_button 'Create User'
		}.to change(User, :count).by(1)
	end
end


feature "Visit Profile" do
	before(:each) do
		@user = User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation=> "abc123")
	end
	it "be able to visit the profile" do
		visit user_path(@user.id)

		page.should have_content "#{@user.handle.capitalize}"
	end

	it "be able to click on all questions and get all user questions" do
		visit user_path(@user.id)
		click_link('All user questions')

		page.should have_content('All Questions')
	end

	it "be able to click on all answers and get all user answers" do
		visit user_path(@user.id)
		click_link('All user answers')

		page.should have_content('All Answers')
	end
end

feature 'User Profile' do
	before(:each) do
		sign_in
		click_link 'Handle'
	end

	context 'with Editing' do
		it "should see Edit Profile link in Profile Page" do
			page.should have_content 'Edit Profile'
		end

		it "should change handle" do 
			click_link 'Edit Profile'
			fill_in 'user_handle', with: 'handle2'
			click_button 'Edit User'
			visit logout_path
			visit login_path
			fill_in 'session_handle', with: 'handle2'
			fill_in 'session_password', with: 'password'
			click_button 'Login'
			click_link 'Handle2'
			page.should have_content "Handle2's Profile"
		end
	end
end

feature 'Admin Capabilities' do
	before(:each) do
		sign_in_admin
	end

	context "User Profile" do
		it "should be able to edit other users' profiles" do
			click_link 'Edit Profile'
			fill_in 'user_handle', with: 'handle3'
			click_button 'Edit User'
			visit logout_path
			visit login_path
			fill_in 'session_handle', with: 'handle3'
			fill_in 'session_password', with: 'password'
			click_button 'Login'
			click_link 'Handle3'
			page.should have_content "Handle3's Profile"
		end

		it "should be able to disable another user account" do
			pending
		end
	end

	context "Postings" do
		it "should be able to edit other users' Questions" do
			click_link 'All user questions'
			page.should have_content "TestQ"
			click_link 'TestQ'
			click_link 'Edit'
		end
	end
end

feature 'Deactivate User' do
	before(:each) do
		sign_in
		click_link 'Handle'
	end

	it "should see a deactivate account link" do
		page.should have_content "deactivate account"
	end
end

