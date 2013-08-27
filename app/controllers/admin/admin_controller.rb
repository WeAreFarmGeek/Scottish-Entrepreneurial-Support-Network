class Admin::AdminController < ::ApplicationController
  around_filter :check_login, :except => [:check_login, :login, :tree]
  layout :admin_layout

  def admin_layout
    'admin'
  end

  private 

  def check_login
    unless current_user
      redirect_to login_path, :notice => "Sorry, you'll need to login to access that page."
    end

    # Yields to the controller method
    # so that the flow of the application can continue
    # normally.
    yield

  end

end
