class LoginController < ApplicationController

  def index
  end

  def login
    username = params[:user][:username]
    password = params[:user][:password]

    user = User.find_by_username(username)
    user = user.authenticate(password) if user

    if user
      session[:user_id] = user.id
      redirect_to :admin_organisations, :notice => 'Successfully Logged in'
    else
      redirect_to login_path, :error => 'Your username or password was not recognised'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path, :notice => 'Successfully logged out'
  end


  private


  def user_params
    params.require(:user).permit(:username, :password)
  end

end
