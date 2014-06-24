require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe '.create' do
      it 'charges the card succesfully', :vcr do
        token = Stripe::Token.create(
          :card => {
            :number => "4242424242424242",
            :exp_month => 6,
            :exp_year => 2018,
            :cvc => "314"
          }
        ).id
        response = StripeWrapper::Charge.create(amount: 300, stripe_token: token,
                                                description: "A valid charge")
        expect(response).to be_successful
      end
      it 'makes a declined card charge', :vcr do
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
            :exp_month => 6,
            :exp_year => 2018,
            :cvc => "314"
          }
        ).id
        response = StripeWrapper::Charge.create(amount: 300, stripe_token: token,
                                                description: "A invalid charge")
        expect(response).not_to be_successful
      end
      it 'returns the error message for declined charge', :vcr do
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
            :exp_month => 6,
            :exp_year => 2018,
            :cvc => "314"
          }
        ).id
        response = StripeWrapper::Charge.create(amount: 300, stripe_token: token,
                                                description: "A invalid charge")
        expect(response.error_message).to be_present
      end
    end
  end
end
