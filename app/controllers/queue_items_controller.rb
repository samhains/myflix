class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_items = current_user.queue_items 
  end
  
  def create
    video = Video.find(params[:video_id])
    review = Review.most_recent_review(current_user.id, video.id)  
    current_user_video_included?(video)
    QueueItem.create(video_id: (video.id unless current_user_video_included?(video)), user: current_user, review: review, order: new_item_order)
    redirect_to my_queue_path 
  end
  
  def destroy
    QueueItem.destroy(params[:id]) if users_queue_item?(params[:id])
    redirect_to my_queue_path
  end

  private

  def users_queue_item?(queue_id)
    QueueItem.find(queue_id).user == current_user
  end

  def new_item_order
    current_user.queue_items.count+1
  end

  def current_user_video_included?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
end
