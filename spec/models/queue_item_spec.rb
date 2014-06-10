require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }
  describe '#video_title' do
    it 'returns the title of the associated video' do
      video = Fabricate(:video, title: 'Kung Fu Panda')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Kung Fu Panda')
    end
  end
  describe '#rating' do
    it 'return the rating from the current user review when it is present' do
      video = Fabricate(:video)
      user = Fabricate(:user)      
      queue_item = Fabricate(:queue_item, video: video, user: user)
      Fabricate(:review, rating:3, user: user,video: video)
      expect(queue_item.rating).to eq(3)
    end
    it 'return nil when the current user review is not present' do
      video = Fabricate(:video)
      user = Fabricate(:user)      
      queue_item = Fabricate(:queue_item, video: video, user: user)
      Fabricate(:review, rating:3, video: video)
      expect(queue_item.rating).to eq(nil)
    end
  end
  describe '#rating=' do
    context 'the review is present' do
      it 'update the rating from the current user review' do
        video = Fabricate(:video)
        user = Fabricate(:user)
        review = Fabricate(:review, rating:3, user: user, video: video)
        queue_item = Fabricate(:queue_item, video: video, user: user)
        queue_item.rating = 5
        expect(queue_item.rating).to eq(5)
      end
      it 'clear the rating from the curren tuser review' do
        video = Fabricate(:video)
        user = Fabricate(:user)
        review = Fabricate(:review, rating:3, user: user, video: video)
        queue_item = Fabricate(:queue_item, video: video, user: user)
        queue_item.rating = nil
        expect(queue_item.rating).to be_nil
      end
    end
    context 'the review is not present' do
      it 'create a review with rating for the current user' do
        video = Fabricate(:video)
        user = Fabricate(:user)
        queue_item = Fabricate(:queue_item, video: video, user: user)
        queue_item.rating = 5
        expect(queue_item.rating).to eq(5)        
      end
    end
  end
  describe '#category_name' do
    it "return the category name of the associated video" do
      category = Fabricate(:category, name: 'TV shows')
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq('TV shows')  
    end    
  end
  describe '#category' do
    it 'return the category of the associated video' do
      category = Fabricate(:category, name: 'TV shows')
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)        
    end
  end
end