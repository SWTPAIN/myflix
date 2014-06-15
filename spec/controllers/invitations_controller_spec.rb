require 'spec_helper'

describe InvitationsController do 
  describe 'POST create' do     
    it 'redirects to home path' do
      post :create, name: 'someone', email: 'someone@gmail.com', message: 'something'
      expect(response).to redirect_to root_path
    end
    it 'send the email to the friend email address' do
      post :create, name: 'someone', email: 'someone@gmail.com', message: 'something'
      email = ActionMailer::Base.deliveries.last
      expect(email.to).to eq(someone@gmail.com)
    end
  end

end