require 'spec_helper'

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
			fill_in 'user_password_digest', with: "password"
			click_button 'Create User'
		}.to change(User, :count).by(1)
	end
end