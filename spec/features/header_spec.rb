require 'spec_helper'

feature 'Header' do
	it "should show the header" do
		visit '/'
		page.should have_content "Login"
		visit new_question_path
		page.should have_content "Login"
	end
end