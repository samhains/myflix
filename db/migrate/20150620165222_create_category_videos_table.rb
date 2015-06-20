class CreateCategoryVideosTable < ActiveRecord::Migration
  def change
    create_table :category_videos do |t|
      t.integer :video_id
      t.integer :category_id
    end
  end
end
