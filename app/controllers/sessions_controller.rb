class SessionsController < ApplicationController
  before_action :redirect_to_show_page_if_logged_in, only: [:new, :create]
  
  def new
    render :new
  end
  
  def create
    user = User.find_by_credentials(
                   params[:user][:email],
                   params[:user][:password]
                 )
    if user.nil?
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    else
      if user.activated?
        sign_in(user)
        #need sign in logic with session tokens
        redirect_to user_url(user)
      else
        flash[:activate_errors] = ["Must activate account!"]
        redirect_to new_session_url
      end
    end
  end
  
  def destroy
    sign_out(current_user)
    redirect_to new_session_url
  end
  
end
