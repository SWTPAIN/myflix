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
    context 'with valid input' do
      before { post :create, user: Fabricate.attributes_for(:user) }
      it "create the user" do
        expect(User.count).to eq(1)
      end
      it "redirect_to sign in template" do
        expect(response).to redirect_to sign_in_path
      end
    end
    context 'with invalid input' do
      before { post :create, user: { password: 'password' } }
      it 'does not create the user' do
        expect(User.count).to eq(0)
      end
      it "render the :new template" do
        expect(response).to render_template :new
      end
      it 'set @user variable' do
        post :create, user: { password: 'password'}
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end