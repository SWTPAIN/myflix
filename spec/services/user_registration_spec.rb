require 'spec_helper'

describe UserRegistration do 
  describe '#registrate' do
    context 'with valid personal info and valid card' do
      before do
        charge = double('charge', successful?: true, error_message: 'Error')
        expect(StripeWrapper::Charge).to receive(:create).and_return(charge)
      end
      after { ActionMailer::Base.deliveries.clear }
      it "creates a user" do
        UserRegistration.new(Fabricate.build(:user)).registrate('some_token', nil)
        expect(User.count).to eq(1)
      end
      it 'makes the user follow the inviter' do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, recipient_email: 'bob@gmail.com', inviter: alice)
        UserRegistration.new(Fabricate.build(:user, email: 'bob@gmail.com')).registrate('some_token', invitation.token)
        bob = User.where(email: 'bob@gmail.com').first
        expect(bob.follows?(alice)).to be true 
      end
      it 'makes the inviter follow the user' do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, recipient_email: 'bob@gmail.com', inviter: alice)
        UserRegistration.new(Fabricate.build(:user, email: 'bob@gmail.com')).registrate('some_token', invitation.token)
        bob = User.where(email: 'bob@gmail.com').first
        expect(alice.follows?(bob)).to be true
      end
      it 'expires the invitation upon acceptance' do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, recipient_email: 'bob@gmail.com', inviter: alice)
        UserRegistration.new(Fabricate.build(:user)).registrate('some_token', invitation.token)
        expect(Invitation.first.token).to be_nil
      end
      it 'sends out the email to the user with valid input' do
        UserRegistration.new(Fabricate.build(:user, email: 'alice@gmail.com')).registrate('some_token', nil)
        expect(ActionMailer::Base.deliveries.last.to).to eq(['alice@gmail.com'])       
      end
      it 'sends out the email containing user name with valid input ' do
        UserRegistration.new(Fabricate.build(:user, full_name:'Alice')).registrate('some_token', nil)
        expect(ActionMailer::Base.deliveries.last.body).to include('Alice')       
      end
    end

    context 'with valid personal info and declined card' do
      it 'does not create a new user' do
        charge = double('charge', successful?: false, error_message: 'Declined')
        expect(StripeWrapper::Charge).to receive(:create).and_return(charge)
        UserRegistration.new(Fabricate.build(:user)).registrate('some_token', nil)
        expect(User.count).to eq(0)
      end
    end
    context 'with invalid person info input' do
      it 'does not create a new user' do
        UserRegistration.new(Fabricate.build(:user, full_name: nil)).registrate('some_token', nil)
        expect(User.count).to eq(0)
      end
      it 'does not charge the credit card' do
        expect(StripeWrapper::Charge).not_to receive(:create)
        UserRegistration.new(Fabricate.build(:user, full_name: nil)).registrate('some_token', nil)
      end   
      it 'does not send the email' do
        UserRegistration.new(Fabricate.build(:user, full_name: nil)).registrate('some_token', nil)
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end