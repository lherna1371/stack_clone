class SessionsController < ApplicationController

  def create
  	@user = User.find_by_handle(params[:session][:handle])
    
    if @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to users_path
    else
      puts @errors = "Username and Password didn't match"
      redirect_to('/')
    end
  end

  def destroy
    session.clear
    redirect_to('/')
  end
end