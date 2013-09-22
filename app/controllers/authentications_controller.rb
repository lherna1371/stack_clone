class AuthenticationsController < ApplicationController

	def index
	  @authentications = current_user.authentications if current_user
	end

	def create
		# render :text => omniauth.to_yaml
		omniauth = request.env["omniauth.auth"]
		provider = omniauth[:provider]
		uid = omniauth[:uid]
		nickname = omniauth[:info].nickname

	  authentication = Authentication.find_by_provider_and_uid(provider, uid)
	  if authentication
	  	user = authentication.user
	  	session[:user_id] = user.id
      redirect_to questions_path, :notice => "Signed in succesfully!"
	  elsif current_user
	  	current_user.authentications.create!(:provider => provider, :uid => uid)
	  	flash[:notice] = "Authentication successful."
	  	redirect_to authentications_path
	  else
	  	@user = User.new(handle: nickname, email: "#{nickname}@twitter.com" ,password: uid ,password_confirmation: uid )
	    @user.authentications.build(:provider => provider, :uid => uid)
	    if @user.save
	    	session[:user_id] = @user.id
	      flash[:notice] = "Signed in successfully."
	      redirect_to questions_path, :notice => "Signed in succesfully!"
	    else
	      redirect_to :back, :notice => "Authentication failed try again"
	    end
		end
	end

	def destroy
	  @authentication = current_user.authentications.find(params[:id])
	  @authentication.destroy
	  flash[:notice] = "Successfully destroyed authentication."
	  redirect_to authentications_url
	end
end