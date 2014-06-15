require 'spec_helper'

describe ResetPasswordsController do
  describe 'GET show' do
    it 'renders show template if the token is valid' do
      alice = Fabricate(:user)
      get :show, id: alice.token
      expect(response).to render_template  :show 
    end
    it 'set @user ' do
      alice = Fabricate(:user)
      get :show, id: alice.token
      expect(assigns(:user)).to eq(alice)
    end
    it 'redirects to the expired token page if the token is invalid' do
      get :show, id: '3213213'
      expect(response).to redirect_to expired_token_path
    end
  end
  describe 'POST create' do
    context 'with valid token' do
      it 'redirects to the sign in page' do
        alice = Fabricate(:user)
        post :create, token: alice.token, password: "alice"
        expect(response).to redirect_to sign_in_path
      end
      it 'updates the user password with valid input' do
        alice = Fabricate(:user)
        post :create, token: alice.token, password: "alice"
        expect(alice.reload.authenticate("alice")).to be_truthy
      end
      it 'sets the flash notice' do
        alice = Fabricate(:user)
        post :create, token: alice.token, password: "alice"
        expect(flash[:notice]).to be_present
      end
      it 'regenerates the user token to nil' do
        alice = Fabricate(:user)
        alice.update_column(:token, '12345')
        post :create, token: alice.token, password: "alice"
        expect(alice.reload.token).not_to eq('12345')
      end
    end
    context 'with invalid token' do
      it 'redirects to the expired token path' do
        post :create, token: 'some_token', password: 'some_password'
        expect(response).to redirect_to expired_token_path
      end
    end
  end

end