class SessionsController < ApplicationController

  def create
  	@user = User.find_by_handle(params[:session][:handle])
    
    if @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to questions_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to('/')
  end
end