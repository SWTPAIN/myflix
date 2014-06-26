class ReviewsController < ApplicationController
  before_action :require_user
  def create
    @video = VideoDecorator.new(Video.find_by(slug: params[:video_id]))
    review = @video.reviews.new(params.require(:review).permit!.merge(user: current_user))
    if review.save
      redirect_to video_path(@video)
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end    
  end
end 