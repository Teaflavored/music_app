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
      sign_in(@user)
      #still need to log user in
      redirect_to user_url(@user)
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
  
  private
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
