class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_items = current_user.queue_items 
  end
  
  def create
    video = Video.find(params[:video_id])
    current_user_video_included?(video)
    QueueItem.create(
      video_id: (video.id unless current_user_video_included?(video)), 
      user: current_user, 
      order: new_item_order
    )
    redirect_to my_queue_path 
  end

  def update_queue
    begin
      ActiveRecord::Base.transaction do
      order_queue_items
      normalize_queue_item_order
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Invalid position"
    end
    redirect_to my_queue_path
  end
  
  def destroy
    QueueItem.destroy(params[:id]) if current_user.has_queue_item?(params[:id])
    normalize_queue_item_order
    redirect_to my_queue_path
  end

  private
  def order_queue_items
    params[:queue_items].each do |queue_item_data|
      update_queue_item = QueueItem.find(queue_item_data[:id])
      if current_user == update_queue_item.user
        update_queue_item.update_attributes!(order: queue_item_data[:order])
      end
    end
  end

  def normalize_queue_item_order 
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(order: index+1)
    end
  end

  def new_item_order
    current_user.queue_items.count+1
  end

  def current_user_video_included?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
end
