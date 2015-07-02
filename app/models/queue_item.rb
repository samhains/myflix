class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  belongs_to :review
  validates_presence_of :video, :user
  delegate :title, to: :video, prefix: :video
  delegate :rating, to: :review
  delegate :name, to: :category, prefix: :category

  def category
    video.categories.first
  end
end
