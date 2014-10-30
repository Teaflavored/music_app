class UsersController < ApplicationController
  before_action :redirect_to_show_page_if_logged_in, only: [:new, :create]
  before_action :redirect_unless_admin, only: :index
  
  def new
    @user = User.new
    #used for reflection to get values after fail
    render :new
  end
  
  def admin
    @user = User.find(params[:user_id])
    @user.toggle!(:admin)
    redirect_to users_url
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
    if current_user != User.find(params[:id])
      redirect_to bands_url
    else
      @user = User.find(params[:id])
      render :show
    end
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
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to user_url(@user)
  end
  
  private
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
    
    def redirect_unless_admin
      redirect_to user_url(current_user) unless current_user.admin?
    end
    
end
