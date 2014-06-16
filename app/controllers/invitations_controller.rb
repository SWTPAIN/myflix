class InvitationsController < ApplicationController
  before_action :require_user
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(friend_params.merge(inviter: current_user))
    if @invitation.save
      flash[:info] = "You have successfully invited #{@invitation.recipient_name} ."
      AppMailer.send_invitation_email(@invitation).deliver
      redirect_to root_path
    else
      flash[:danger] = "Please check your input."
      render :new
    end
  end

  def friend_params
    params.require(:invitation).permit!
  end 

end