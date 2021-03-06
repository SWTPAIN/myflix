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
    @user = User.find_by(slug: params[:id])
  end

  def create
    @user = User.new(user_params)
    stripe_token = params[:stripeToken]
    invitation_token = params[:invitation_token]
    result = UserRegistration.new(@user).registrate(stripe_token, invitation_token)
    if result.successful?
      flash[:info] = 'You have sucessfully signed in. Please login it with your account.'
      redirect_to sign_in_path
    else
      flash[:danger] = result.error_message
      render :new
    end
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:info] = "Your profile is updated"
      redirect_to home_path
    else
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:full_name, :password, :email, :password_confirmation)
  end

end