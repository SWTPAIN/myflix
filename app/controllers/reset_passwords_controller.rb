class ResetPasswordsController < ApplicationController
  
  def show
    @user = User.where(token: params[:id]).first
    redirect_to expired_token_path unless @user
  end

  def create
    user = User.where(token: params[:token]).first

    if user
      user.password = params[:password]
      user.generate_token
      user.save
      flash[:info] = "Your passowrd has been changed. Please login it with new password"
      redirect_to sign_in_path
    else
      redirect_to expired_token_path
    end
  end

end