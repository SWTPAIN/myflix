class InvitationsController < ApplicationController
  
  def new
  end

  def create
    redirect_to root_path
    AppMailer.send_invitation_email(friend_params)
  end

  def friend_params
    params.permit(:name, :email, :message)
  end

end