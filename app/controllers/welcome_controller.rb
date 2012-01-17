class WelcomeController < ApplicationController

  skip_before_filter :login_required, :only => :login

  def index
  end

  # handles login and register
  def login
    @user = User.new params[:user]
    if meth = params[:type]
      usr = @user.send(meth)
      unless usr.new_record? # registration/login success
        session[:user_id] = usr.id
        redirect_to(root_url)
      end
    end
  end

  def logout
    reset_session
    redirect_to(root_url)
  end
end
