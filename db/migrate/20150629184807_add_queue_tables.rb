class AddQueueTables < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :review_id
      t.integer :order
      t.timestamps
    end

    add_index :queue_items, :user_id
    add_index :queue_items, :video_id
    add_index :queue_items, :review_id
  end
end
