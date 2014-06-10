class QueueItemsController < ApplicationController
  before_action :require_user
  
  def index
    @queue_items = current_user.queue_items
  end
  
  def create
    video = Video.find(params[:video_id])
    queue_video(video)
   
    redirect_to my_queue_path
  end
  
  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    current_user.normalize_queue_position
    redirect_to my_queue_path
  end
  
  def update_multiple
    begin
      current_user.update_queue_items(params[:queue_items])
      current_user.normalize_queue_position
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Invalid position number of queue items."
    ensure
      redirect_to my_queue_path
    end
  end

  private

  def queue_video(video)
    QueueItem.create(video: video, user: current_user,
                     position:new_queue_item_position) unless current_user.has_queued_video?(video)
  end

  def new_queue_item_position
    current_user.queue_items.count+1
  end

end