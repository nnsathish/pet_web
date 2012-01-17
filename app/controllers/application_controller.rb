class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :login_required

protected
  def login_required
    access_denied if session[:user_id].nil?
  end

  def access_denied
    redirect_to login_url, :notice => "Please login!"
  end
end
