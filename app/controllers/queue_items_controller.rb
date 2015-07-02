class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_items = current_user.queue_items 
  end
  
  def create
    @review = Review.most_recent_review(current_user.id, params[:video_id])
    @queue_item = QueueItem.new(video_id: params[:video_id], user: current_user, review: @review)
    if @queue_item.save
      flash[:success] = "Added to Queue!"
      redirect_to my_queue_path
    else
      flash[:error] = "There has been a problem"
      render 'videos/show'
    end
  end



end  
