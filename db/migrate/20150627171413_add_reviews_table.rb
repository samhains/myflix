class AddReviewsTable < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :description
      t.integer :user_id
    end
    add_index :reviews, :user_id
  end
end
