class UsersController < ApplicationController
	def index
		@users = User.all
	end
	
  def create
	  @user = User.new(handle: params[:user][:handle], email: params[:user][:email],password: params[:user][:password],password_confirmation:params[:user][:password_confirmation] )

	  if @user.save
	    session[:user_id] = @user.id
	    redirect_to users_path
	  else
	    redirect_to new_user_path
	  end
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
  	if current_user
  		@user = User.find(current_user.id)
  	else
  		redirect_to login_path
  	end
  end
end