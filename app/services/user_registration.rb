class UserRegistration
  attr_reader :error_message
  def initialize(user)
    @user = user
  end

  def registrate(stripe_token, invitation_token)
    if @user.valid?
      customer = StripeWrapper::Customer.create(
        user: @user,
        stripe_token: stripe_token
      )
      if customer.successful?
        @user.customer_token = customer.customer_token
        @user.save
        handle_invitation(invitation_token)
        AppMailer.delay.send_welcome_email(@user)
        @status = :success
      else
        @status = :fail
        @error_message = customer.error_message
      end
    else
      @status = :fail
      @error_message = "Invalid user information. Please check the errors below."      
    end 
    self
  end

  def successful?
    @status == :success
  end


  private

  def handle_invitation(invitation_token)
    if invitation_token.present?
      invitation = Invitation.where(token: invitation_token).first
      @user.follows(invitation.inviter)
      invitation.inviter.follows(@user)
      invitation.update_attributes(token: nil)
    end
  end

end