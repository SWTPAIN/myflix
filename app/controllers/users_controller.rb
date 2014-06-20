class UsersController < ApplicationController
  before_action :require_user, only: :show
  
  def new
    @user = User.new
    redirect_to home_path if current_user
  end

  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      handle_invitation
      handle_charge
      flash[:info] = 'You have sucessfully signed in. Please login it with your account.'
      AppMailer.delay.send_welcome_email(@user)
      redirect_to sign_in_path
    else
      render :new
    end 
  end

  private

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.where(token: params[:invitation_token]).first
      @user.follows(invitation.inviter)
      invitation.inviter.follows(@user)
      invitation.update_attributes(token: nil)
    end
  end

  def handle_charge
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    Stripe::Charge.create(
        :amount => 999,
        :currency => 'usd',
        :card => params[:stripeToken],
        :description => "Sign up charge for #{@user.full_name} (#{@user.email})"
    )
  end
  
  def user_params
    params.require(:user).permit(:full_name, :password, :email)
  end

end