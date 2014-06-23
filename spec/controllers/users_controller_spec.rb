require 'spec_helper'

describe UsersController do 
  describe 'GET new' do
    it 'set the @user variable' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
    it 'redirect if the user already login' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe 'POST create' do
    context 'with successful user registration' do
        before do
          result = double(:result, successful?: true )
          expect_any_instance_of(UserRegistration).to receive(:registrate).and_return(result)
          post :create, user: Fabricate.attributes_for(:user)
        end
      it "redirects to sign in template" do
        expect(response).to redirect_to sign_in_path
      end
      it 'set the flash info' do
        expect(flash[:info]).to be_present
      end
    end
    context 'with failed user registration' do
      before do
        result = double(:result, successful?: false, error_message: 'Error' )
        expect_any_instance_of(UserRegistration).to receive(:registrate).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
      end
      it 'renders the :new template' do
        expect(response).to render_template :new
      end
      it 'sets the flash danger' do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe 'GET show' do
    it 'set the @user' do
      set_current_user
      alice = Fabricate(:user)
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
    it_behaves_like 'require sign in' do
      let (:action) { get :show, id: 3}
    end 
  end

  describe 'GET new_with_invitation_token' do
    it 'renders the :new template' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end
    it 'sets the @user with the recipient email' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email) 
    end
    it 'sets the @invitation_token' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end
    it 'redirects to expired token page for invalid token' do
      get :new_with_invitation_token, token: 'some_token'
      expect(response).to redirect_to expired_token_path
    end
  end
end