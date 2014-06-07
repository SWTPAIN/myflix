require 'spec_helper'

describe VideosController do 
  describe 'GET show' do 
    it 'set the @video for authenticated user' do 
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id 
      expect(assigns(:video)).to eq(video) 
    end
    it 'sets the @review for authenticated user' do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id 
      expect(assigns(:reviews)).to match_array([review1, review2])    
    end
    it 'redirect the user to the sign in page for with unauthenticated users' do 
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'Get search' do
    it "set the @search_result for authenticated users" do 
      session[:user_id] = Fabricate(:user).id
      batman = Fabricate(:video, title: "Batman")
      get :search, search_term: 'man'
      expect(assigns(:search_result)).to eq([batman])
    end

    it "redirect to sign in page for the unauthenticated user" do
      batman = Fabricate(:video, title: "Batman")
      get :search, search_term: 'man'
      expect(response).to redirect_to sign_in_path
    end
  end
end
