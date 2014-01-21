class LoginController < ApplicationController

  def index
  end

  def login
    email    = params[:user][:email]
    password = params[:user][:password]

    user = User.find_by_email(email)
    user = user.authenticate(password) if user

    if user
      session[:user_id] = user.id
      redirect_to :admin_organisations, :notice => 'Successfully Logged in'
    else
      redirect_to login_path, :error => 'Your email or password was not recognised'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path, :notice => 'Successfully logged out'
  end

  def signup
    user = User.new
    #user.update_attributes(user_params, request) if user_params.length > 0
    user.update_attributes(user_params) if user_params.length > 0
    if user.save
      session[:user_id] = user.id
      redirect_to :admin_organisations, :notice => 'Successfully Registered & Logged in'
    else
      if user_params.length > 0
        flash[:alert] = "Your email or password was not valid: #{user.errors.full_messages.join(", ")}"
      end
    end
  end

  private

  def user_params
    params[:user]
  end

end
