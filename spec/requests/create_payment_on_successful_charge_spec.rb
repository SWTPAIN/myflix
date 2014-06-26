require 'spec_helper'

describe "Create payment on successful charge" do 
  let(:event_data) do
    {
      "id"=> "evt_104Hhn4wbmLLpyqJNnWgmj9l",
      "created"=> 1403671899,
      "livemode"=> false,
      "type"=> "charge.succeeded",
      "data"=> {
        "object"=> {
          "id"=> "ch_104Hhn4wbmLLpyqJeSEOCP5b",
          "object"=> "charge",
          "created"=> 1403671899,
          "livemode"=> false,
          "paid"=> true,
          "amount"=> 999,
          "currency"=> "usd",
          "refunded"=> false,
          "card"=> {
            "id"=> "card_104Hhn4wbmLLpyqJsYIozdRh",
            "object"=> "card",
            "last4"=> "4242",
            "brand"=> "Visa",
            "funding"=> "credit",
            "exp_month"=> 6,
            "exp_year"=> 2014,
            "fingerprint"=> "etWFp7zuTFpJYqPr",
            "country"=> "US",
            "name"=> nil,
            "address_line1"=> nil,
            "address_line2"=> nil,
            "address_city"=> nil,
            "address_state"=> nil,
            "address_zip"=> nil,
            "address_country"=> nil,
            "cvc_check"=> "pass",
            "address_line1_check"=> nil,
            "address_zip_check"=> nil,
            "customer"=> "cus_4HhnlzKhsgFC4P"
          },
          "captured"=> true,
          "refunds"=> {
            "object"=> "list",
            "total_count"=> 0,
            "has_more"=> false,
            "url"=> "/v1/charges/ch_104Hhn4wbmLLpyqJeSEOCP5b/refunds",
            "data"=> []
          },
          "balance_transaction"=> "txn_104Hhn4wbmLLpyqJnnx9Sz3w",
          "failure_message"=> nil,
          "failure_code"=> nil,
          "amount_refunded"=> 0,
          "customer"=> "cus_4HhnlzKhsgFC4P",
          "invoice"=> "in_104Hhn4wbmLLpyqJvpAcj8XY",
          "description"=> nil,
          "dispute"=> nil,
          "metadata"=> {},
          "statement_description"=> nil,
          "receipt_email"=> nil
        }
      },
      "object"=> "event",
      "pending_webhooks"=> 1,
      "request"=> "iar_4HhnGJ2LRm5Vvl"
    }
  end
  it 'creates a payment with the webhook from stripe for successful charge', :vcr do
    post stripe_event_path, event_data
    expect(Payment.count).to eq(1)
  end
  it 'create a payment associated with the user', :vcr do
    alice = Fabricate(:user, customer_token: 'cus_4HhnlzKhsgFC4P')
    post stripe_event_path, event_data
    expect(Payment.last.user).to eq(alice)
  end
  it 'create a payment with the amount', :vcr do
    post stripe_event_path, event_data
    expect(Payment.last.amount).to eq(999)
  end
  it 'create a payment with the reference id', :vcr do
    post stripe_event_path, event_data
    expect(Payment.last.reference_id).to eq("ch_104Hhn4wbmLLpyqJeSEOCP5b") 
  end
end