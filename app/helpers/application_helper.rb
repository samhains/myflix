module ApplicationHelper
  def average_rating(video)
    avg = video.reviews.inject(0) { |sum,el| sum += el.rating }

    if avg ==0
      "Unrated" 
    else
      (avg.to_f/video.reviews.count).round(2)
    end
  end

  def options_for_ratings(selected=nil)
    options_for_select( [5,4,3,2,1].map{|num| [pluralize(num, "Star"),num]}, selected )
  end

  def video_in_queue(video)
    current_user.queue_items.map(&:video).include?(video)
  end
end
