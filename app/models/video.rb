class Video < ActiveRecord::Base
  has_many :category_videos
  has_many :categories, through: :category_videos
end