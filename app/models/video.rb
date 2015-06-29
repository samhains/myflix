class Video < ActiveRecord::Base
  has_many :category_videos
  has_many :reviews, -> {order("created_at")}
  has_many :categories, -> {order( :name )}, through: :category_videos
  validates_presence_of :title, :description

  def self.search_by_title(title)
    return [] if title.blank?
    where(["title LIKE ?", "%#{title}%"]).order('created_at DESC')
  end

end
