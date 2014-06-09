require 'spec_helper'
require 'pry'
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
  describe 'DELETE destroy' do
    it 'redirect to the my queue path for authenticated user' do
      queue_item = Fabricate(:queue_item)
      session[:user_id] = Fabricate(:user).id
      delete :destroy, id: queue_item.id      
      expect(response).to redirect_to my_queue_path
    end
    it 'delete the queue_item from the queue of the sign in user' do
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user)
      session[:user_id] = user.id
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
    it 'normalize the position numbers of remaining queue items' do
      user = Fabricate(:user)
      queue_item1 = Fabricate(:queue_item, position: 1, user: user)
      queue_item2 = Fabricate(:queue_item, position: 2, user: user)
      session[:user_id] = user.id
      delete :destroy, id:queue_item1.id
      expect(queue_item2.reload.position).to eq(1)
    end
    it 'does not delete the queue item if it is not in the current user queue' do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user1)
      session[:user_id] = user2.id
      delete :destroy, id:queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    it 'redirects to the sign in path for the unauthenticated user' do
      delete :destroy, id: 3
      expect(response).to redirect_to sign_in_path
    end
  end
  describe 'PATCH update_multiple' do
    context "with valid input" do
      it 'redirects to the my queue path for authenticated user' do
        queue_item1 = Fabricate(:queue_item, position:1)
        queue_item2 = Fabricate(:queue_item, position:2)
        session[:user_id] = Fabricate(:user).id
        patch :update_multiple, queue_item_positions: [{queue_item_id: queue_item1.id, position: "2"},{queue_item_id: queue_item2.id, position: "1"}]
        expect(response).to redirect_to my_queue_path 
      end
      it 'reorder the queue_item' do
        user = Fabricate(:user)
        session[:user_id] = user.id      
        queue_item1 = Fabricate(:queue_item, user: user, position:1)
        queue_item2 = Fabricate(:queue_item, user: user, position:2)
        patch :update_multiple, queue_item_positions: [{queue_item_id: queue_item1.id, position: 2},
          {queue_item_id: queue_item2.id, position: 1}]
        expect(user.queue_items).to eq([queue_item2,queue_item1])
      end 
      it 'normalize the position numbers' do
        user = Fabricate(:user)
        session[:user_id] = user.id      
        queue_item1 = Fabricate(:queue_item, user: user, position:1)
        queue_item2 = Fabricate(:queue_item, user: user, position:2)
        patch :update_multiple, queue_item_positions: [{queue_item_id: queue_item1.id, position: 3},
          {queue_item_id: queue_item2.id, position: 2}]
        expect(user.queue_items.map(&:position)).to eq([1,2])
      end
    end
    context "with invalid input" do
      it 'redirect_to my queue path' do
        user = Fabricate(:user)
        session[:user_id] = user.id      
        queue_item1 = Fabricate(:queue_item, user: user, position:1)
        queue_item2 = Fabricate(:queue_item, user: user, position:2)
        patch :update_multiple, queue_item_positions: [{queue_item_id: queue_item1.id, position: 3.5},
          {queue_item_id: queue_item2.id, position: 2}]
        expect(response).to redirect_to my_queue_path
      end
      it 'set the flash danger notice' do
        user = Fabricate(:user)
        session[:user_id] = user.id      
        queue_item1 = Fabricate(:queue_item, user: user, position:1)
        queue_item2 = Fabricate(:queue_item, user: user, position:2)
        patch :update_multiple, queue_item_positions: [{queue_item_id: queue_item1.id, position: 3.5},
          {queue_item_id: queue_item2.id, position: 2}]
        expect(flash[:danger]).not_to be_blank
      end
      it 'does not change the queue items' do
        user = Fabricate(:user)
        session[:user_id]   = user.id      
        queue_item1 = Fabricate(:queue_item, user: user, position:1)
        queue_item2 = Fabricate(:queue_item, user: user, position:2)
        patch :update_multiple, queue_item_positions: [{queue_item_id: queue_item1.id, position: 3},
          {queue_item_id: queue_item2.id, position: 2.5}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
    context "with unauthenticated user" do
      it 'redirects to the sing in path' do
        patch :update_multiple, queue_item_positions: [{queue_item_id: 1, position: 3},
          {queue_item_id: 2, position: 2.5}]
        expect(response).to redirect_to sign_in_path        
      end
    end
    context "with queue_item that do not belong to the current user" do
      it 'does not change the queue items' do
        alice = Fabricate(:user)
        mike = Fabricate(:user)
        session[:user_id]   = alice.id      
        queue_item1 = Fabricate(:queue_item, user: mike, position:1)
        queue_item2 = Fabricate(:queue_item, user: mike, position:2)
        patch :update_multiple, queue_item_positions: [{queue_item_id: queue_item1.id, position: 2},
          {queue_item_id: queue_item2.id, position: 1}]
        expect(queue_item1.reload.position).to eq(1)
      end
      it 'redirects to the my queue path' do
      end
    end
  end

end