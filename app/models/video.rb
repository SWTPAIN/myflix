class Video < ActiveRecord::Base
  include Sluggable
  belongs_to :category
  has_many :reviews, -> { order("created_at DESC") } 

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  validates_presence_of :title, :description
  sluggable_column :title


  def self.search_by_title(search_term)
    return [] if search_term.blank?
    self.where("title LIKE ?", "%#{search_term}%").order(created_at: :desc)
  end

  def rating 
    reviews.average(:rating).round(1) if reviews.average(:rating)
  end

end


