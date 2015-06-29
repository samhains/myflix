class ReviewsController < ApplicationController
  before_action :require_user

 #need to have review associated with a particular video path
  #then need to render the video
  def create
    @video = Video.find(params[:id])
    @review = Review.new(review_params.merge!(creator: current_user, video: @video))

    if @review.save
      flash[:success] = "You have posted the review"
      redirect_to video_path
    else
      @reviews = @video.reviews
      flash[:danger] = "There was a problem with your submission"
      render 'videos/show'
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :description)
  end

end
