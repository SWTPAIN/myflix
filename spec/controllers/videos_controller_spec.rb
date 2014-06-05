require 'spec_helper'

describe VideosController do 
  describe 'GET show' do 
    it 'set the @video' do 
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id 
      expect(assigns(:video)).to eq(video) 
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
    # it 'set the @search_result to empty if it not in the table' do 
    #   session[:user_id] = Fabricate(:user).id
    #   get :search, search_term: 'something'
    #   expect(assigns(:search_result)).to eq([])
    # end
    # it 'set the @search_result if ' do 
    #   session[:usre_id] = Fabricate(:user).id
    #   video1 =Fabrocate(:)
    #   get :search, search_term: 'something'
    #   expect(assigns(:search_result)).to eq([])
    # end
  end
end
