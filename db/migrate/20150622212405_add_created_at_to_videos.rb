class AddCreatedAtToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :created_at, :timestamp 
  end
end
