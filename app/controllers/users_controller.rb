class UsersController < ApplicationController
  before_action :require_user, only: :show
  
  def new
    @user = User.new
    redirect_to home_path if current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = 'You have sucessfully signed in. Please login it with your account.'
      AppMailer.send_welcome_email(@user).deliver
      redirect_to sign_in_path
    else
      render :new
    end 
  end

  def show
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:full_name, :password, :email)
  end

end