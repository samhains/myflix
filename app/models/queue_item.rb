class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates_presence_of :video, :user
  validates_numericality_of :order, only_integer: true
  delegate :title, to: :video, prefix: :video
  delegate :name, to: :category, prefix: :category

  def rating
    review.rating if review
  end

  def rating=(rating_num)
    if review
      review.update_attribute(:rating, rating_num) 
    else
      new_review = Review.new(
        creator: user, 
        rating: rating_num,
        video: video
      )
      new_review.save(validate:false)
    end
  end

  def category
    video.categories.first
  end

  private
  def review
   @review ||= Review.where(user_id: user.id, video_id: video.id).order("created_at DESC").first
  end
end
