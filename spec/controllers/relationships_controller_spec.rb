require 'spec_helper'

describe RelationshipsController do 
  describe 'GET index' do 

    it_behaves_like 'require sign in' do
      let (:action) { get :index }
    end

    it 'sets the @relationships to the current user following relationships' do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end

  end
  describe 'DELETE destroy' do

    it_behaves_like 'require sign in' do
      let (:action) { delete :destroy, id: 3 }
    end
    it 'redirects to people path' do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)      
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end
    it 'delete the follwoing relationship if the current user is the follower' do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)      
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end
    it 'doesn not delete the follwoing relationship if the current user is not the follower' do
      alice = Fabricate(:user)
      set_current_user
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)      
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end

  end
  describe'Post create' do
    it_behaves_like 'require sign in' do
      let (:action) { post :create, leader_id: 3 }
    end
    it 'create the following relationship for the current user ' do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      post :create, leader_id: bob.id
      expect(alice.following_relationships.first.leader).to eq(bob)      
    end
    it 'redirect to the people page' do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      post :create, leader_id: bob.id
      expect(response).to redirect_to people_path        
    end

    it 'does not create the same following relationship for the current user with a leader twice' do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: alice, leader: bob)
      post :create, leader_id: bob.id
      expect(alice.following_relationships.where(leader: bob).count).to eq(1)
    end
    it 'does not create the following relationship for the current user with themselves' do
      alice = Fabricate(:user)
      set_current_user(alice)
      post :create, leader_id: alice.id
      expect(alice.following_relationships.count).to eq(0)
    end

  end
end