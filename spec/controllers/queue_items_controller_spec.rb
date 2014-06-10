require 'spec_helper'
require 'pry'
describe QueueItemsController do 
  describe 'GET index' do
    it 'sets the @queue_items to the queue item of the authenticated user' do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1,queue_item2])
    end
    it_behaves_like 'require sign in' do
      let (:action) { get :index}
    end
  end
  describe 'POST create' do
    it 'redirects to my_queue path' do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it 'creates a queue_item for authenticated user' do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)      
    end 
    it 'creates the queue_item assoicated with the video' do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)          
    end
    it 'creates the queue_item assoicated with the singed in user' do
      alice = Fabricate(:user)
      set_current_user(alice)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(alice)    
    end
    it 'puts the queue_item as the last one in my_queue' do
      dragon =  Fabricate(:video)
      witcher = Fabricate(:video)
      alice = Fabricate(:user)
      set_current_user(alice)
      Fabricate(:queue_item, video: dragon, user: alice)
      post :create, video_id: witcher.id
      witcher_queue_item = QueueItem.where(video: witcher, user: alice).first
      expect(witcher_queue_item.position).to eq(2)
    end
    it 'does not add the video if it is already in the user queue' do
      dragon =  Fabricate(:video)
      alice = Fabricate(:user)
      set_current_user(alice)
      Fabricate(:queue_item, video: dragon, user: alice)
      post :create, video_id: dragon.id
      expect(alice.queue_items.count).to eq(1)      
    end
    it 'redirect to the sing_in path for unauthenticated user' do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path        
    end
  end
  describe 'DELETE destroy' do
    it 'redirect to the my queue path for authenticated user' do
      queue_item = Fabricate(:queue_item)
      set_current_user
      delete :destroy, id: queue_item.id      
      expect(response).to redirect_to my_queue_path
    end
    it 'delete the queue_item from the queue of the sign in user' do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item = Fabricate(:queue_item, user: alice)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
    it 'normalize the position numbers of remaining queue items' do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item1 = Fabricate(:queue_item, position: 1, user: alice)
      queue_item2 = Fabricate(:queue_item, position: 2, user: alice)
      delete :destroy, id:queue_item1.id
      expect(queue_item2.reload.position).to eq(1)
    end
    it 'does not delete the queue item if it is not in the current user queue' do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(alice)
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id:queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    it_behaves_like 'require sign in' do
      let (:action) { delete :destroy, id: 3}
    end
  end
  describe 'PATCH update_multiple' do

    it_behaves_like 'require sign in' do
      let (:action) do 
        patch :update_multiple, queue_items: [{queue_item_id: 1, position: 3},
        {queue_item_id: 2, position: 2.5}]
      end
    end

    context "with valid input" do

      let ( :alice) { Fabricate(:user) }
      let ( :video1) { Fabricate(:video) }
      let ( :video2) { Fabricate(:video) }
      let ( :queue_item1) { Fabricate(:queue_item, video: video1, user: alice, position:1) }
      let ( :queue_item2) { Fabricate(:queue_item, video: video2, user: alice, position:1) }

      before { set_current_user(alice) }

      it 'redirects to the my queue path for authenticated user' do
        patch :update_multiple, queue_items: [{queue_item_id: queue_item1.id, position: "2"},{queue_item_id: queue_item2.id, position: "1"}]
        expect(response).to redirect_to my_queue_path 
      end
      it 'reorder the queue_item' do
        patch :update_multiple, queue_items: [{queue_item_id: queue_item1.id, position: 2},
          {queue_item_id: queue_item2.id, position: 1}]
        expect(alice.queue_items).to eq([queue_item2,queue_item1])
      end 
      it 'normalize the position numbers' do
        patch :update_multiple, queue_items: [{queue_item_id: queue_item1.id, position: 3},
          {queue_item_id: queue_item2.id, position: 2}]
        expect(alice.queue_items.map(&:position)).to eq([1,2])
      end
    end

    context "with invalid input" do

      let ( :alice) { Fabricate(:user) }
      let ( :video1) { Fabricate(:video) }
      let ( :video2) { Fabricate(:video) }
      let ( :queue_item1) { Fabricate(:queue_item, video: video1, user: alice, position:1) }
      let ( :queue_item2) { Fabricate(:queue_item, video: video2, user: alice, position:1) }

      before { set_current_user(alice) }

      it 'redirect_to my queue path' do
        patch :update_multiple, queue_items: [{queue_item_id: queue_item1.id, position: 3.5},
          {queue_item_id: queue_item2.id, position: 2}]
        expect(response).to redirect_to my_queue_path
      end
      it 'set the flash danger notice' do
        patch :update_multiple, queue_items: [{queue_item_id: queue_item1.id, position: 3.5},
          {queue_item_id: queue_item2.id, position: 2}]
        expect(flash[:danger]).not_to be_blank
      end
      it 'does not change the queue items' do
        patch :update_multiple, queue_items: [{queue_item_id: queue_item1.id, position: 3},
          {queue_item_id: queue_item2.id, position: 2.5}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    context "with queue_item that do not belong to the current user" do
      it 'does not change the queue items' do
        alice = Fabricate(:user)
        set_current_user(alice)
        bob = Fabricate(:user)
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, video: video1, user: bob, position:1)
        queue_item2 = Fabricate(:queue_item, video: video2, user: bob, position:2)
        patch :update_multiple, queue_items: [{queue_item_id: queue_item1.id, position: 2},
          {queue_item_id: queue_item2.id, position: 1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end

end