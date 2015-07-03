class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates_presence_of :video, :user
  delegate :title, to: :video, prefix: :video
  delegate :name, to: :category, prefix: :category

  def rating
    video.reviews.first.rating
  end

  def category
    video.categories.first
  end

end
