module StripeWrapper
  class Charge
    attr_reader :response, :status
    def self.create(options={})
      Stripe::Charge.create(
        :amount => options[:amount],
        :currency => 'usd',
        :card => options[:stripe_token],
        :description => options[:description]
      )
    end

    def self.set_api_key
      Stripe.api_key =  ENV["STRIPE_SECRET_KEY"]
    end
  end
end

