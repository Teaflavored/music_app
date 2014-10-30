class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  
  def logged_in?
    !current_user.nil?
  end
  
  def current_user
    User.find_by(session_token: session[:session_token])
  end
  
  def sign_in(user)
    user.reset_session_token!
    #reset user's session token, then set it in the cookie
    session[:session_token] = user.session_token
  end
  
  def sign_out(user)
    user.reset_session_token!
    session[:session_token] = nil
  end
  
  def redirect_to_show_page_if_logged_in
    redirect_to user_url(current_user) unless current_user.nil?
  end
  
  def redirect_to_sign_in_if_not_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
