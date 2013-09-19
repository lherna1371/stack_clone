module UserHelper
	def two_users

		User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation=> "abc123")
    User.create!(:handle => "Test2", :email => "b@b.com", :password=> "abc123", :password_confirmation=> "abc123")
  end

  def sign_in
  	a = User.create!(handle: "handle",email: "test@test.com",password: "password", password_confirmation: "password")
  	visit login_path
  	fill_in 'session_handle', with: "handle"
  	fill_in 'session_password', with: "password"
  	
  	click_button 'Login'
  end
end