class AddVideoToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :video_id, :integer
    add_index :reviews, :video_id
  end
end
