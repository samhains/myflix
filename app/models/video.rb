class Video < ActiveRecord::Base
  has_many :category_videos
  has_many :categories, -> {order( :name )}, through: :category_videos
  validates_presence_of :title, :description
end