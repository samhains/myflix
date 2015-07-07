class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates_presence_of :video, :user
  validates_numericality_of :order, only_integer: true
  delegate :title, to: :video, prefix: :video
  delegate :name, to: :category, prefix: :category

  def rating
    video.reviews.first.rating unless video.reviews.empty?
  end

  def category
    video.categories.first
  end

  def update_queue

  end
end
