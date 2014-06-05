require 'spec_helper'

describe SessionsController do 
  describe 'GET new' do
    it 'renders the new template for unauthenticated users' do
      get :new
      expect(response).to render_template :new
    end
    it 'redirects to home path for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end
  describe 'POST create' do
    context 'with valid credential input' do
      before do
        michael = Fabricate(:user)
        post :create, email: michael.email, password: michael.password
      end   
         
      it 'puts the signed in user in the the session' do
        expect(session[:user_id]).to eq(michael.id)
      end
      it 'redirects to home_path' do
        expect(response).to redirect_to home_path        
      end
      it 'sets the info notice' do
        expect(flash[:info]).not_to be_blank
      end
      
    end
    context 'with invald credential input' do
      before do
        michael = Fabricate(:user)
        post :create, email: 'other@gmail.com', password: michael.password
      end
      it 'does not put the signed in user in the session' do
        expect(session[:user_id]).to eq(nil)
      end
      it 'redirects to sign in path' do
        expect(response).to redirect_to sign_in_path
      end

      it 'sets the error notice' do
        expect(flash[:danger]).not_to be_blank        
      end
    end
  end
  describe 'GET destroy' do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    it 'sets the session to nil for the user' do
      expect(session[:user_id]).to be_nil
    end
    it 'redirects to the root path' do
      expect(response).to redirect_to root_path      
    end
    it 'sets the info notice' do
      expect(flash[:info]).not_to be_blank      
    end
  end

end 