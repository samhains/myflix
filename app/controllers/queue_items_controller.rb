class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_items = current_user.queue_items 
  end
  
  def create
    video = Video.find(params[:video_id])
    #current_user_video_included?(video) if video
    @review = Review.most_recent_review(current_user.id, video.id)  
    current_user_video_included?(video)
    @queue_item = QueueItem.new(video_id: (video.id unless current_user_video_included?(video)), user: current_user, review: @review, order: new_item_order)
    @queue_item.save 
    flash[:success] = "Added to Queue!"
    redirect_to my_queue_path 
  end

  private

  def new_item_order
    current_user.queue_items.count+1
  end

  def current_user_video_included?(video)
    #.map(&: is the equivalent of calling .video on each element in array
    current_user.queue_items.map(&:video).include?(video)
  end
end
