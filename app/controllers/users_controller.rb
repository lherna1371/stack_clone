class UsersController < ActionController::Base
	def index
		@users = User.all
	end
  def create
	  @user = User.new(handle: params[:user][:handle], email: params[:user][:email],password_digest: params[:user][:password_digest])

	  if @user.save
	    session[:user_id] = @user.id
	    redirect_to users_path
	  else
	    redirect_to new_user_path
	  end
  end
end