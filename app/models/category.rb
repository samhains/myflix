class Category  < ActiveRecord::Base
  has_many :category_videos
  has_many :videos, ->{order('created_at DESC')}, through: :category_videos

  def recent_videos
    videos.first(6)
  end
end
