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