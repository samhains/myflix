module ApplicationHelper
  def average_rating(video)
    avg = video.reviews.inject(0) do |sum,el|
      sum += el.rating
    end
    (avg.to_f/video.reviews.count).round(2)
  end
end
