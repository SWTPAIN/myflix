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

  class Customer
    attr_reader :response, :error_message
    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end
    def self.create(options={})
      begin
        response = Stripe::Customer.create(
          :card => options[:stripe_token],
          :plan => "base",
          :email => options[:user].email
        )
        new(response: response)
      rescue Stripe::CardError => e
        body = e.json_body
        err = body[:error]
        new(error_message: err[:message])
      end
    end
    def self.retrieve(customer_token)
      begin
        response = Stripe::Customer.retrieve(customer_token)
        new(response: response)
      rescue Stripe::InvalidRequestError => e
        new(error_message: e.message)
      end
    end
    
    def subscription
      subscription_data = response[:subscriptions][:data][0]
      { name: subscription_data[:plan][:name],
        amount: subscription_data[:plan][:amount],
        current_billing_end_at: subscription_data[:current_period_end]
      }
    end

    def successful?
      response.present?
    end
    def customer_token
      response.id
    end
  end

end

