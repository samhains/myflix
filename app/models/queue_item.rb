class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  belongs_to :review

  def video_title
    video.title
  end
  
  def rating
    review.rating
  end

  def category
    video.categories.first
  end
  
  def category_name
    category.name
  end
end
