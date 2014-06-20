require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe '.create' do
      it 'charges the card succesfully', :vcr do
        StripeWrapper::Charge.set_api_key
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
        expect(response.amount).to eq(300)
        expect(response.currency).to eq('usd')
      end
    end
  end
end
