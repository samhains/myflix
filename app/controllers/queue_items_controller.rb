class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_items = current_user.queue_items 
  end
  
  def create
    video = Video.find(params[:video_id])
    current_user.video_included?(video)
    QueueItem.create(
      video: (video unless current_user.video_included?(video)), 
      user: current_user, 
      order: new_item_order
    )
    redirect_to my_queue_path 
  end

  def update_queue
    begin
      update_queue_items
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

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        update_queue_item = QueueItem.find(queue_item_data[:id])
        if current_user == update_queue_item.user
          update_queue_item.update_attributes!(order: queue_item_data[:order], rating: queue_item_data[:rating])
        end
      end
      current_user.normalize_queue_item_order
    end
  end

  def new_item_order
    current_user.queue_items.count+1
  end

end
