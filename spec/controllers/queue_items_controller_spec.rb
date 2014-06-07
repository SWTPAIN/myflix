require 'spec_helper'

describe QueueItemsController do 
  describe 'GET index' do
    it 'sets the @queue_items to the queue item of the authenticated user' do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1,queue_item2])
    end
    it 'redirects to sing in path for unauthenticated user' do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end
  describe 'POST create' do
    it 'redirects to my_queue path' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it 'creates a queue_item for authenticated user' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)      
    end 
    it 'creates the queue_item assoicated with the video' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)          
    end
    it 'creates the queue_item assoicated with the singed in user' do
      video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(user)    
    end
    it 'puts the queue_item as the last one in my_queue' do
      dragon =  Fabricate(:video)
      witcher = Fabricate(:video)
      user = Fabricate(:user)
      Fabricate(:queue_item, video: dragon, user: user)
      session[:user_id] = user.id
      post :create, video_id: witcher.id
      witcher_queue_item = QueueItem.where(video: witcher, user: user).first
      expect(witcher_queue_item.position).to eq(2)
    end
    it 'does not add the video if it is already in the user queue' do
      dragon =  Fabricate(:video)
      user = Fabricate(:user)
      Fabricate(:queue_item, video: dragon, user: user)
      session[:user_id] = user.id
      post :create, video_id: dragon.id
      expect(user.queue_items.count).to eq(1)      
    end
    it 'redirect to the sing_in path for unauthenticated user' do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path        
    end
  end
end