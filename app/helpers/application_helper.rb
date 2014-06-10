module ApplicationHelper
  def display_video_average_rating(video)
    "Rating: #{average_video_rating(video)}/5.0"
  end

  def average_video_rating(video)
    if video.reviews.blank?
      '-'
    else
      video.reviews.map(&:rating).inject(0,:+)/video.reviews.count.to_f
    end     
  end

  def options_for_video_review(selected=nil)
    options_for_select([5,4,3,2,1].map {|num| [pluralize(num, "Star"), num]},selected)
  end
end
