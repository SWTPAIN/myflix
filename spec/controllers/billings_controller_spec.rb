require 'spec_helper'

describe BillingsController do 
  describe 'GET show' do
    it_behaves_like 'require sign in' do
      let(:action) { get :index}
    end 
    it 'set the @subscription variable' do
      set_current_user
      customer = double('customer', subscription: 'subscription')
      expect(StripeWrapper::Customer).to receive(:retrieve).and_return(customer)
      get :index
      expect(assigns(:subscription)).to be_present
    end
    it 'set the @payments varaible' do
      alice = Fabricate(:user)
      set_current_user(alice)
      customer = double('customer', subscription: 'subscription')
      expect(StripeWrapper::Customer).to receive(:retrieve).and_return(customer)
      Fabricate(:payment, user:alice)
      Fabricate(:payment, user:alice)
      get :index
      expect(assigns(:payments)).to be_present
    end
    it 'renedrs the show page' do
      set_current_user
      customer = double('customer', subscription: 'subscription')
      expect(StripeWrapper::Customer).to receive(:retrieve).and_return(customer)
      get :index
      expect(response).to render_template :index
    end
  end
end