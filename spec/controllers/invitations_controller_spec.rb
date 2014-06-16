require 'spec_helper'

describe InvitationsController do 
  describe 'GET new' do
    it 'sets the @invitation to a new invitation' do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of(Invitation)
    end
    it_behaves_like "require sign in" do
      let (:action) { get :new }
    end
  end
  describe 'POST create' do     
    after { ActionMailer::Base.deliveries.clear}
    it_behaves_like "require sign in" do
      let (:action) { post :create, invitation: Fabricate.attributes_for(:invitation)}
    end
    context 'with valid input' do
      it 'redirects to home path' do
        set_current_user
        post :create, invitation: Fabricate.attributes_for(:invitation)
        expect(response).to redirect_to root_path
      end
      it 'set the flash notice' do
        set_current_user
        post :create, invitation: Fabricate.attributes_for(:invitation)
        expect(flash[:info]).to be_present
      end
      it 'creates a invitation' do
        set_current_user
        post :create, invitation: Fabricate.attributes_for(:invitation)  
        expect(Invitation.count).to eq(1)
      end
      it 'creates a invitation associated with the user' do
        alice = Fabricate(:user)
        set_current_user(alice)
        post :create, invitation: Fabricate.attributes_for(:invitation)  
        expect(Invitation.last.inviter).to eq(alice)
      end
      it 'sends an email to the recipient email address' do
        set_current_user
        post :create, invitation: { recipient_name:'Bob', recipient_email: "bob@gmail.com", message: 'Join it!' }
        email = ActionMailer::Base.deliveries.last
        expect(email.to).to eq(['bob@gmail.com'])
      end
    end
    context 'with invalid input' do
      before do
        set_current_user
        post :create, invitation: { recipient_email: "bob@gmail.com" }
      end
      it 'render the invitation new template' do
        expect(response).to render_template :new        
      end
      it 'does not create a invitation' do
        expect(Invitation.count).to eq(0)
      end
      it 'does not send out an email' do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
      it 'set the flash danger' do
        expect(flash[:danger]).to be_present
      end
      it 'set the @invitation' do
        expect(assigns(:invitation)).to be_present
      end
    end
  end

end