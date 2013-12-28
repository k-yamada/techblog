class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :set_setting

  def set_setting
    @setting = Setting.get_data
  end

  private

  def current_user
    @current_user ||= session[:user_info] if session[:user_info]
  end
end
