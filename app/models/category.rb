class Category < ActiveRecord::Base
  include Sluggable
  has_many :videos, -> {order("created_at DESC")} 
  validates_presence_of :name
  sluggable_column :name

  # order: :title 
  def recent_videos
    videos.first(6)
  end
end