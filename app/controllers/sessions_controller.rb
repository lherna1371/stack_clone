class SessionsController < ApplicationController

  def create
  	@user = User.find_by_handle(params[:session][:handle])
    if @user == nil
      flash[:error] = "The user you have entered does not exist, please use sign up link above"
      redirect_to login_path
    else
      if @user.is_active?
        if  @user.authenticate(params[:session][:password])
          session[:user_id] = @user.id
          redirect_to questions_path, :notice => "Signed in!"
        else
          flash[:error] = "Handle or Password is incorrect"
          redirect_to login_path, :notice => "Signed in!"
        end
      else
        @error = "Your account is not active"
        render 'account/update'
      end
    end
  end

  def destroy
    session.clear
    redirect_to('/')
  end
end