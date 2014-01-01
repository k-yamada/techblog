class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :current_setting

  def set_admin_view
    @admin_view = true
  end

  private

  def current_user
    @current_user ||= session[:user_info] if session[:user_info]
  end

  def current_setting
    @current_setting ||= Setting.get_data
  end
end
