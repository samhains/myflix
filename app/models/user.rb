class User < ActiveRecord::Base
  validates_presence_of :name, :password,:email_address
  validates :password, length: {minimum: 5, maximum: 30}
  validates_uniqueness_of :email_address 
  has_many :reviews
  has_many :queue_items, -> { order(:order) }
  has_secure_password validations: false

  def has_queue_item?(queue_id)
    QueueItem.find(queue_id).user == self
  end

 
end
