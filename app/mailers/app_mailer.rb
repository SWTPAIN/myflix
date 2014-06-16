class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: @user.email, from: "info@myflix.com", subject: 'Welcome to MyFlix.'
  end
  
  def send_reset_password_email(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: 'Please reset youur pssword'
  end
  
  def send_invitation_email(invitation)
    @invitation = invitation
    mail to: invitation.recipient_email, from: "info@myflix.com",
     subject: "Invitation to join MyFlix" 
  end
end