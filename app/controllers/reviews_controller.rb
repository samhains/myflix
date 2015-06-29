class ReviewsController < ApplicationController
  before_action :require_user

 #need to have review associated with a particular video path
  #then need to render the video
  def create
    @review = Review.new(review_params)
    @review.creator = current_user
    @video = Video.find(params[:id])
    @review.video = @video
    if @review.save
      flash[:success] = "You have posted the review"
      redirect_to video_path
    else
      flash[:danger] = "There was a problem with your submission"
      render 'videos/show'
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :description)
  end

end
