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

  def sign_in_admin
    b = User.create!(handle: "handle2",email: "test2@test.com",password: "password", password_confirmation: "password")
    b.questions.create(:title => 'TestQ', :content => "Current Content")
    a = User.create!(handle: "handle",email: "test@test.com",password: "password", password_confirmation: "password")
    a.admin = true
    a.save
    visit login_path
    
    fill_in 'session_handle', with: "handle"
    fill_in 'session_password', with: "password"
    click_button 'Login'
    visit user_path(b.id)
  end
end