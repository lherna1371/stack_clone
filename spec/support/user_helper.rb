module UserHelper
	def two_users
		User.create!(:handle => "Test1", :email => "a@b.com", :password => "abc123", :password_confirmation => "abc123")
    User.create!(:handle => "Test2", :email => "b@b.com", :password => "abc123", :password_confirmation => "abc123")
  end

  def sign_in
  	u = User.create!(:handle => "Test3", :email => "a@c.com", :password => "abc123", :password_confirmation => "abc123")
  	
  end
end