class SessionsController < ApplicationController

  def create
  	@user = User.find_by_handle(params[:session][:handle])
    if @user.is_active?
      if @user != nil && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        redirect_to questions_path
      else
        flash[:error] = "Handle or Password is incorrect"
        redirect_to login_path
      end
    else
      @error = "Your account is not active"
      render 'account/update'
    end
  end

  def destroy
    session.clear
    redirect_to('/')
  end
end