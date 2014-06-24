class VideoDecorator < Draper::Decorator
  delegate_all
  def displayed_rating
    object.rating ? "Rating: #{object.rating}/5.0" : "Rating: - /5.0"
  end

end