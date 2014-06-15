require 'spec_helper'

describe ForgotPasswordsController do 
  describe 'POST create' do
    context 'with blank input' do
      it 'redirects to forgot password page' do
        post :create, email: ""
        expect(response).to redirect_to forgot_password_path
      end
      it 'shows an error message' do
        post :create, email: ""
        expect(flash[:danger]).not_to be_blank
      end 
    end
    context 'with existing email input' do
      before do
        Fabricate(:user, email: 'alice@gmail.com')
      end
      after { ActionMailer::Base.deliveries.clear}
      it 'redirects to the forgot password confirmation page' do
        post :create, email: 'alice@gmail.com'
        expect(response).to redirect_to forgot_password_confirmation_path        
      end
      it 'sends the emails to the user email address' do
        post :create, email: 'alice@gmail.com'
        email = ActionMailer::Base.deliveries.last 
        expect(email.to).to eq(['alice@gmail.com']) 
      end
    end
    context 'with non-existing email input' do
      it 'redirects to the forgot password confirmation page' do
        post :create, email: 'alice@gmail.com'
        expect(response).to redirect_to forgot_password_confirmation_path        
      end
      it 'does not send the email to the email address' do
        post :create, email: 'alice@gmail.com'
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end