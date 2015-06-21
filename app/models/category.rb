class Category  < ActiveRecord::Base
  has_many :category_videos
  has_many :videos, ->{order(:title)}, through: :category_videos

end