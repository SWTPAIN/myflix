class User < ActiveRecord::Base
  include Tokenable
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_secure_password validations: false

  has_many :reviews, -> {order("created_at DESC")}
  has_many :queue_items, -> { order(:position)}
  has_many :following_relationships, class_name: "Relationship", foreign_key: 'follower_id'

  
  def normalize_queue_position
    queue_items.each_with_index { |queue_item, index| 
      queue_item.update_attributes(position: index+1)}
  end

  def has_queued_video?(video)
    !queue_items.where(video: video).blank?
  end

  def update_queue_items(queue_items)
    ActiveRecord::Base.transaction do    
      queue_items.each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:queue_item_id])
        queue_item.update_attributes!(
          position: queue_item_data[:position], rating: queue_item_data[:rating]) if self.queue_items.include?(queue_item)
      end
    end
  end

  def follows(another_user)
    following_relationships.create(leader: another_user) if can_follow?(another_user)
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end

  def can_follow?(another_user)
    !(self.follows?(another_user) || self == another_user)
  end

end