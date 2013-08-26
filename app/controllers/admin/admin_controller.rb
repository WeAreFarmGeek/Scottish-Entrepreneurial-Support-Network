class Admin::AdminController < ApplicationController
  layout :admin_layout

  def admin_layout
    'admin'
  end
end
