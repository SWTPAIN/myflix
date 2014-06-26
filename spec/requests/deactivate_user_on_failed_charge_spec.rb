require 'spec_helper'

describe 'Deactivate user on failed charge' do
  let(:event_data) do
    {
      "id" => "evt_104Hls4wbmLLpyqJuB1ugU4m",
      "created" => 1403687098,
      "livemode" => false,
      "type" => "charge.failed",
      "data" => {
        "object" => {
          "id" => "ch_104Hls4wbmLLpyqJoLwNkHMG",
          "object" => "charge",
          "created" => 1403687098,
          "livemode" => false,
          "paid" => false,
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "card" => {
            "id" => "card_104Hls4wbmLLpyqJhQ79w9Zn",
            "object" => "card",
            "last4" => "0341",
            "brand" => "Visa",
            "funding" => "credit",
            "exp_month" => 6,
            "exp_year" => 2015,
            "fingerprint" => "YHSC8MXwtQ8DrEXX",
            "country" => "US",
            "name" => nil,
            "address_line1" => nil,
            "address_line2" => nil,
            "address_city" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_country" => nil,
            "cvc_check" => "pass",
            "address_line1_check" => nil,
            "address_zip_check" => nil,
            "customer" => "cus_4HUdA4foOplPUe"
          },
          "captured" => false,
          "refunds" => {
            "object" => "list",
            "total_count" => 0,
            "has_more" => false,
            "url" => "/v1/charges/ch_104Hls4wbmLLpyqJoLwNkHMG/refunds",
            "data" => []
          },
          "balance_transaction" => nil,
          "failure_message" => "Your card was declined.",
          "failure_code" => "card_declined",
          "amount_refunded" => 0,
          "customer" => "cus_4HUdA4foOplPUe",
          "invoice" => nil,
          "description" => "",
          "dispute" => nil,
          "metadata" => {},
          "statement_description" => nil,
          "receipt_email" => nil
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_4HlsQUjhz9ldNn"
    }
  end
  it 'deactives the user with the webhook from strip for failed charge', :vcr do
    alice = Fabricate(:user, customer_token: "cus_4HUdA4foOplPUe")
    post stripe_event_path, event_data
    expect(alice.reload).not_to be_active
  end
end