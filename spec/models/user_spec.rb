require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:position) }

  describe '#has_queued_video?' do
    it 'returns true when the the video is in user queue' do
      alice = Fabricate(:user)
      monster = Fabricate(:video)
      Fabricate(:queue_item, user: alice, video: monster)
      expect(alice.has_queued_video?(monster)).to eq(true)
    end
    it 'return false when the video is not in user queue' do
      alice = Fabricate(:user)
      monster = Fabricate(:video)
      Fabricate(:queue_item, video: monster)
      expect(alice.has_queued_video?(monster)).to eq(false)
    end
  end


end