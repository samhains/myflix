class AddIndexToCategoryVideos < ActiveRecord::Migration
  def change
    add_index :category_videos, :video_id
    add_index :category_videos, :category_id
  end
end
