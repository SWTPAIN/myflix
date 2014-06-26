require 'spec_helper'

describe StripeWrapper do
  let (:valid_token) do
    Stripe::Token.create(
      :card => {
        :number => "4242424242424242",
        :exp_month => 6,
        :exp_year => 2018,
        :cvc => "314"
      }
    ).id
  end
  let (:declined_card_token) do
    Stripe::Token.create(
      :card => {
        :number => "4000000000000002",
        :exp_month => 6,
        :exp_year => 2018,
        :cvc => "314"
      }
    ).id
  end
  describe StripeWrapper::Charge do
    describe '.create' do
      it 'charges the card succesfully', :vcr do
        response = StripeWrapper::Charge.create(amount: 300, 
                                                stripe_token: valid_token,
                                                description: "A valid charge")
        expect(response).to be_successful
      end
      it 'makes a declined card charge', :vcr do
        response = StripeWrapper::Charge.create(amount: 300,
                                                stripe_token: declined_card_token,
                                                description: "A invalid charge")
        expect(response).not_to be_successful
      end
      it 'returns the error message for declined charge', :vcr do
        response = StripeWrapper::Charge.create(amount: 300,
                                                stripe_token: declined_card_token,
                                                description: "A invalid charge")
        expect(response.error_message).to be_present
      end
    end
  end
  describe StripeWrapper::Customer do
    describe '.create' do
      let(:alice) { Fabricate(:user) }
      it 'creates a customer with valid card' , :vcr do
        response = StripeWrapper::Customer.create(stripe_token: valid_token,
                                                  user: alice)
        expect(response).to be_successful
      end
      it 'return a customer token with valid card', :vcr do
        response = StripeWrapper::Customer.create(stripe_token: valid_token,
                                                  user: alice)
        expect(response.customer_token).to be_present
      end
      it 'does not create a customer with declined card', :vcr do
        response = StripeWrapper::Customer.create(stripe_token: declined_card_token,
                                                  user: alice)
        expect(response).not_to be_successful
      end
      it 'returns the error message for decliend card', :vcr do
        response = StripeWrapper::Customer.create(stripe_token: declined_card_token,
                                                  user: alice)
        expect(response.error_message).to be_present
      end
    end
    describe '.retrieve' do
      it 'creates a customer with valid customer token', :vcr do
        response = StripeWrapper::Customer.retrieve('cus_4HkZtOqymdFBWK')
        expect(response).to be_successful
      end
      it 'does not create a customer with invalid customer token', :vcr do
        response = StripeWrapper::Customer.retrieve('abc')
        expect(response).not_to be_successful
      end
      it 'returns the error  message with invalid customer token', :vcr do
        response = StripeWrapper::Customer.retrieve('abc')
        expect(response.error_message).to be_present
      end
    end
    describe '#subscription' do
      it 'return a hash with subscription information', :vcr do
        response = StripeWrapper::Customer.retrieve('cus_4HkZtOqymdFBWK')
        expect(response.subscription[:name]).to eq("Base Subscription")
        expect(response.subscription[:amount]).to eq(999)
        expect(Time.at(response.subscription[:current_billing_end_at])).to be_instance_of Time 
      end
    end
  end
end
