class Review < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  belongs_to :video
  has_many :queue_items
  validates_presence_of :description, :rating

  def self.most_recent_review(user_id, video_id)
    where(user_id: user_id, video_id: video_id).order('created_at DESC').first
  end
   
end
