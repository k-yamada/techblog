class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :set_blog_info

  def set_blog_info
    @blog_info = {}
    admin = Admin.find_one
    if admin
      @blog_info[:title]    = admin[:title]
      @blog_info[:description] = admin[:description]
    else
      @blog_info[:title]    = "TechBlog"
      @blog_info[:description] = "Description"
    end
  end
  private
  def current_user
    @current_user ||= session[:user_info] if session[:user_info]
  end
end
