module StripeWrapper
  class Charge
    attr_reader :response, :error_message

    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.create(options={})
      begin
        response = Stripe::Charge.create(
          :amount => options[:amount],
          :currency => 'usd',
          :card => options[:stripe_token],
          :description => options[:description]
        )
        new(response: response)
      rescue Stripe::CardError => e
        body = e.json_body
        err = body[:error]
        new(error_message: err[:message])
      end
    end

    def successful?
      response.present?
    end
  end
end

