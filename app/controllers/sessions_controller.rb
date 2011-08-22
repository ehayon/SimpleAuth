class SessionsController < ApplicationController
 
  def new
  end
 
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      @session = Session.new(:user_id => user.id, :user_agent => request.env["HTTP_USER_AGENT"], :expiration_time => 24.hours.from_now)
      if @session.save
        redirect_to root_url, :notice => "logged in"        
      else
        flash.now.alert = "An error occured. Please try again."
        render "new"
      end
    else
      flash.now.alert = "Email/Password Combination is not Valid"
      render "new"
    end
  end
  def get_ua 
    @ua = get_user_agent
  end
  def destroy
    @session = Session.where(:user_id => 1)
    @session.delete_all
    session[:user_id] = nil
    redirect_to root_url, :notice => "logged out"
  end
  
end
