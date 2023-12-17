class ApplicationController < ActionController::Base
  def authenticate_admin_user!
    redirect_to login_path if session[:admin_user_id].nil?
  
    @current_admin_user = User.find_by(id: session[:admin_user_id])
  end

  def current_admin_user
    @current_admin_user ||= User.find_by(id: session[:admin_user_id])
  end
end
