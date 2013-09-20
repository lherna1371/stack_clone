require 'digest/md5'
class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end
	
  def create
	  @user = User.new(handle: params[:user][:handle], email: params[:user][:email],password: params[:user][:password],password_confirmation:params[:user][:password_confirmation] )

    email_address = @user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    image_src = "http://www.gravatar.com/avatar/#{hash}? s=200"
	  @user.photo = image_src
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
  		if current_user.admin
  			@user = User.find(params[:id])
  		else
  			@user = User.find(current_user.id)
  		end
  	else
  		redirect_to login_path
  	end
  end

  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(user_attributes)
      redirect_to user_path(@user.id)
    else
    	@error = 'Profile Not Saved'
      render 'edit'
    end
  end

  private

  def user_attributes
  	params.require(:user).permit(:handle, :email, :password_confirmation, :password)
  end
end