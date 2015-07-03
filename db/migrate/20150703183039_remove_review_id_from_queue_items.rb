class RemoveReviewIdFromQueueItems < ActiveRecord::Migration
  def change
    remove_column :queue_items, :review_id
  end
end
