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
      it "creates the user" do
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
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it 'sets @user variable' do
        post :create, user: { password: 'password'}
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
    context 'sending email' do
      after { ActionMailer::Base.deliveries.clear }
      it 'sends the email to the user with valid input' do
        post :create, user: { email: 'alice@gmail.com', password: 'passowrd',
                              full_name: 'Alice'}
        expect(ActionMailer::Base.deliveries).not_to be_empty       
      end
      it 'sends the email containing user name with valid input ' do
        post :create, user: { email: 'alice@gmail.com', password: 'passowrd',
                              full_name: 'Alice'}
        email = ActionMailer::Base.deliveries.last 
        expect(email.body).to include('Alice')
      end
      it 'does not send the email with invalid content' do
        post :create, user: { email: 'alice@gmail.com', password: 'passowrd'}
        expect(ActionMailer::Base.deliveries).to be_empty
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
end