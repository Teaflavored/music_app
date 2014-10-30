class UsersController < ApplicationController
  before_action :redirect_to_show_page_if_logged_in, only: [:new, :create]
  
  def new
    @user = User.new
    #used for reflection to get values after fail
    render :new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      #still need to log user in
      Usermailer.user_activation_email(@user).deliver
      flash[:success] = ["Successfully created"]
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    render :show
  end
  
  def index
    @users = User.all
    render :index
  end
  
  def activate
    user = User.find_by(activation_token: params[:token])
    if user
      user.toggle!(:activated)
      user.save!
      flash[:success] = ["Successfully activated"]
      sign_in(user)
      redirect_to user_url(user)
    else
      flash[:activate_errors] = ["User is not activated"]
      redirect_to new_session_url
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
    
end
