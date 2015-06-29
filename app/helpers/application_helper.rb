module ApplicationHelper
  def average_rating(video)
    avg = video.reviews.inject(0) { |sum,el| sum += el.rating }

    if avg ==0
      "Unrated" 
    else
      (avg.to_f/video.reviews.count).round(2)
    end
  end
end
