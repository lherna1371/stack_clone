require 'spec_helper'

feature 'auth authentication' do

	context 'sign page' do
		it "displays twitter feature" do
		  visit login_path
		  page.should have_content "Sign in through one of these services:"
		end
	end

	context 'sign up page' do
		it "displays twitter feature" do
		  visit new_user_path
		  page.should have_content "Create auser through one of these services:"
		end

# 		it "clicking twiiter creates a new user" do

# OmniAuth.config.test_mode = true
# OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
#                                                             :provider => 'twitter',
#                                                             :uid => '2222',
#                                                             :info => {
#                                                                 'name' => 'Javier',
#                                                                 'email' => 'javier@test.com'
#                                                             }
#                                                         })
# 	      visit new_user_path
# 	      click_link 'Twitter'
# 	      # page.should have_content "Signed in succesfully!"
# 	      expect(Authentication.last.provider).to eq'2222'
# 	      # expect {click_link 'Twitter'}.to change(User, :count).by(1)
# 	    end
	end

end

