class User < ActiveRecord::Base
  validates_presence_of :name, :password,:email_address
  validates :password, length: {minimum: 5, maximum: 30}
  validates_uniqueness_of :email_address 
  has_many :reviews
  has_many :queue_items, -> { order(:order) }
  has_secure_password validations: false

  def most_recent_review(video_id)
    Review.where(user_id: self.id, video_id: video_id).order('created_at DESC').first
  end

  def has_queue_item?(queue_id)
    QueueItem.find(queue_id).user == self
  end

  def normalize_queue_item_order 
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(order: index+1)
    end
  end
  
  def video_included?(video)
    queue_items.map(&:video).include?(video)
  end
end
