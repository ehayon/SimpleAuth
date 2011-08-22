class ApplicationController < ActionController::Base
  protect_from_forgery
 
  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] && Session.where("user_id = ? AND expiration_time > ?", session[:user_id], Time.now).present?
  end
  
end
