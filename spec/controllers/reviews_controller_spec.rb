require 'spec_helper'

describe ReviewsController do 

  describe 'POST create' do
    let (:video) { Fabricate(:video) }
    
    it_behaves_like 'require sign in' do
      let (:action) { post :create, review: Fabricate.attributes_for(:review), video_id: video.slug
          expect(response).to redirect_to sign_in_path }
    end

    context 'with authenticated user' do
      let (:alice) { Fabricate(:user) }
      before { set_current_user(alice) }
      context 'with valid input' do
        before do
          post :create,  review: Fabricate.attributes_for(:review), video_id: video.slug
        end  
        it 'redirects to the video show page' do
          expect(response).to redirect_to video_path(video)
        end

        it 'creates a review' do
          expect(Review.count).to eq(1)
        end
        it 'creates a review assocoated with the video' do
          expect(Review.first.video).to eq(video)
        end
        it 'creates a review associated with the signed in user' do
          expect(Review.first.user).to eq(alice)
        end
      end
      context 'with invalid input' do
        it 'does not create the review' do
          post :create, review: {rating: 2}, video_id: video.slug
          expect(Review.count).to eq(0)
        end 

        it 'renders to video show page' do
          post :create, review: {rating: 2}, video_id: video.slug
          expect(response).to render_template 'videos/show'
        end
        it 'set @video' do
          post :create, review: {rating: 2}, video_id: video.slug
          expect(assigns(:video)).to eq(video)
        end
        it 'set @reviews' do
          review1 = Fabricate(:review, video: video)
          review2 = Fabricate(:review, video: video)
          post :create, review: {rating: 2}, video_id: video.slug
          expect(assigns(:reviews)).to match_array([review1,review2])
        end
      end
    end
  end
end