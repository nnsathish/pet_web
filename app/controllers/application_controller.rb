class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :login_required # welcome controller skips this for few actions

protected

  def login_required
    access_denied unless logged_in?
  end

  def logged_in?
    !current_user.blank?
  end
  helper_method :logged_in?

  def current_user
    usr_id = session[:user_id]
    return nil if usr_id.blank?

    @current_user ||= User.find_by_id(usr_id)
  end
  helper_method :current_user

  def access_denied
    redirect_to login_path
  end
end
