require 'spec_helper'

describe VideosController do 
  describe 'GET show' do 
    it 'set the @video for authenticated user' do 
      set_current_user
      video = Fabricate(:video)
      get :show, id: video.slug 
      expect(assigns(:video)).to eq(video) 
    end
    it 'sets the @review for authenticated user' do
      set_current_user
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.slug
      expect(assigns(:reviews)).to match_array([review1, review2])    
    end
    it_behaves_like 'require sign in' do
      let (:action) { get :show, id: 5 }
    end
  end

  describe 'Get search' do
    it "set the @search_result for authenticated users" do 
      set_current_user
      batman = Fabricate(:video, title: "Batman")
      get :search, search_term: 'man'
      expect(assigns(:search_result)).to eq([batman])
    end
    it_behaves_like 'require sign in' do
      let (:action) { get :search, search_term: 'man' }
    end
  end
end
