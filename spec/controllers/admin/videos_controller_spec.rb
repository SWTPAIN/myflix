require 'spec_helper'

describe Admin::VideosController do
  describe 'GET new' do
    it_behaves_like 'require sign in' do
      let (:action) { get :new}
    end
    it 'sets the @video to a new video' do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record
    end
    it_behaves_like 'require admin' do
      let (:action) { get :new}
    end
    it 'sets the flash danger for non-admin user ' do
      set_current_user
      get :new
      expect(flash[:danger]).to be_present
    end
  end
  describe 'POST create' do
    it_behaves_like 'require sign in' do
      let (:action) { post :create }
    end
    it_behaves_like 'require admin' do
      let (:action) { post :create }
    end

    context 'with valid input' do
      it 'redirects to the new admin video page' do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "Monk", category_id: category.id, description: "A monk"}
        expect(response).to redirect_to new_admin_video_path
      end

      it 'creates a video' do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "Monk", category_id: category.id, description: "A monk"}
        expect(Video.count).to eq(1)
      end
      it 'sets the flash success notice' do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "Monk", category_id: category.id, description: "A monk"}
        expect(flash[:info]).to be_present
      end
    end
    context 'with invlaid input' do
      it 'does not create a video' do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "A monk"}
        expect(Video.count).to eq(0)
      end
      it 'render the :new template' do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "A monk"}
        expect(response).to render_template :new
      end
      it 'set the @video variable' do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "A monk"}
        expect(assigns(:video)).to be_present
      end
      it 'set the flash error message' do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "A monk"}
        expect(flash[:danger]).to be_present
      end
    end
  end
end