class Review < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  belongs_to :video
  has_many :queue_items
  validates_presence_of :description, :rating
end
