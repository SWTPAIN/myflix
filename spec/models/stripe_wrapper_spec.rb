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
      it 'creates a customer with valid card' , :vcr do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(stripe_token: valid_token,
                                                  user: alice)
        expect(response).to be_successful
      end
      it 'does not create a customer with declined card', :vcr do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(stripe_token: declined_card_token,
                                                  user: alice)
        expect(response).not_to be_successful
      end
      it 'returns the error message for decliend card', :vcr do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(stripe_token: declined_card_token,
                                                  user: alice)
        expect(response.error_message).to be_present
      end
    end
  end
end
