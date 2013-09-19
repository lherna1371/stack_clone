module UserHelper
	def two_users
		User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation => "abc123")
    User.create!(:handle => "Test2", :email => "b@b.com", :password => "abc123", :password_confirmation => "abc123")
  end

  def sign_in
  	a = User.create(handle: "handle",email: "test@test.com",password_digest: "password")
  	a.save
  	session[:user_id] = a.id
  end
end