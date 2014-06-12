require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:reviews).order("created_at DESC") }

  describe '#has_queued_video?' do
    it 'returns true when the the video is in user queue' do
      alice = Fabricate(:user)
      monster = Fabricate(:video)
      Fabricate(:queue_item, user: alice, video: monster)
      expect(alice.has_queued_video?(monster)).to be true
    end
    it 'returns false when the video is not in user queue' do
      alice = Fabricate(:user)
      monster = Fabricate(:video)
      Fabricate(:queue_item, video: monster)
      expect(alice.has_queued_video?(monster)).to be false
    end
  end

  describe '#follows?' do
    it 'returns true when the user has a following relationship with the another user' do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: alice, leader: bob)
      expect(alice.follows?(bob)).to be true
    end
    it 'returns false when the user does not a follwoing relationship with the another user' do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower:bob, leader: alice)
      expect(alice.follows?(bob)).to be false
    end
  end

  describe '#can_follow?' do
    it 'return true if the user does not yet follow the another user and they are not the same user' do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      expect(alice.can_follow?(bob)).to be true
    end
    it 'return false if the user already follow the another user' do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(alice.can_follow?(bob)).to be false
    end
    it 'return false if the user and the another user are the same user' do
      alice = Fabricate(:user)
      expect(alice.can_follow?(alice)).to be false
    end
  end


end