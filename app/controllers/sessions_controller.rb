class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    auth = request.env["omniauth.auth"]
    session[:user_info] = auth["info"]
    if Admin.count == 0
      Admin.create({:email => session[:user_info][:email]})
    end

    unless Admin.find_by(email: session[:user_info][:email])
      session[:user_info] = nil
    end
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_info] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
