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
		sign_in
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

		page.should have_content "Profile"
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