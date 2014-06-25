class BillingsController < ApplicationController
  before_action :require_user
  def index
    @subscription = customer.subscription
    @payments = Payment.where(user: current_user).limit(10).order('created_at DESC')
  end


  private 
  def customer
    @customer || StripeWrapper::Customer.retrieve(current_user.customer_token)    
  end

end