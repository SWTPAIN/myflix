class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_numericality_of :position, {only_integer: true}
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  def rating
    review.rating if review
  end

  def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating)
    else
      Review.new(user_id: user.id, video_id: video.id, rating:new_rating).save(validate: false)
    end
  end

  def category_name
    category.name
  end

  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end
end