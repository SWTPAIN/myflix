class ForgotPasswordsController < ApplicationController

  def create
    user = User.where(email: params[:email]).first
    if user 
      AppMailer.delay.send_reset_password_email(user)
      redirect_to forgot_password_confirmation_path
    elsif params[:email].blank?
      flash[:danger] = 'Email cannot be blank' 
      redirect_to forgot_password_path
    else
      redirect_to forgot_password_confirmation_path 
    end
  end


end