class WelcomeController < ApplicationController

  skip_before_filter :login_required, :except => [:index, :logout]

  def index
    @budget = current_user.budget
  end

  # handles login and register
  def login
    redirect_to(root_url) && return if logged_in?
    @user = User.new params[:user]
    if meth = params[:type]
      usr = @user.send(meth)
      unless usr.new_record? # registration/login success
        session[:user_id] = usr.id
        redirect_to(root_url)
      end
    end
  end

  def change_password
  end

  def logout
    reset_session
    @current_user = nil
    redirect_to(root_url)
  end
end
