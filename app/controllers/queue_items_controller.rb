class QueueItemsController < ApplicationController
  before_action :require_user
  def index
   @queue_items = current_user.queue_items 
  end
  
  def create
    video = Video.find(params[:video_id])
    current_user.video_included?(video)
    QueueItem.create(
      video_id: (video.id unless current_user.video_included?(video)), 
      user: current_user, 
      order: new_item_order
    )
    redirect_to my_queue_path 
  end

  def update_queue
    begin
      current_user.update_queue(params[:queue_items])
      current_user.update_reviews(params[:queue_items])
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Invalid position"
    end
    redirect_to my_queue_path
  end
  
  def destroy
    QueueItem.destroy(params[:id]) if current_user.has_queue_item?(params[:id])
    current_user.normalize_queue_item_order
    redirect_to my_queue_path
  end

  private

  def new_item_order
    current_user.queue_items.count+1
  end

end
