require 'spec_helper'

describe QueueItem do
  let(:user) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }
  let(:review) { Fabricate(:review, video: video, creator: user ) }
  let(:queue_item) { Fabricate(:queue_item, video: video, user: user) }
  let(:category) { video.categories.first }
  it { should validate_numericality_of(:order).only_integer }
  it { should belong_to(:video) }
  it { should belong_to(:user) }

  describe "#video_title" do
    it "gets the video title" do
      expect(queue_item.video_title).to eq(video.title)
    end
  end
  
  describe "#rating" do
    it "gets the review rating" do
      video.reviews << review
      video.save
      expect(queue_item.rating).to eq(review.rating)
    end
  end

  describe "#rating=" do
    it "updates the rating number if there is an existing review" do
      review = Fabricate(:review, rating: 1)
      video = Fabricate(:video, reviews: [review])
      queue_item = Fabricate(:queue_item, video: video)
      queue_item.rating = 4
      expect(queue_item.reload.rating).to eq(4)
    end

    it "creates a new rating if there is no existing review" do
      queue_item = Fabricate(:queue_item)
      queue_item.rating = 4
      expect(queue_item.reload.rating).to eq(4)
    end

    it "removes the rating if the input is blank" do
      user = Fabricate(:user)
      review = Fabricate(:review, creator: user, rating: 1)
      video = Fabricate(:video, reviews: [review])
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = ""
      expect(queue_item.reload.rating).to be_nil
    end
  end

  describe "#category" do
    it "gets the first category" do
      expect(queue_item.category).to  eq(category)
    end
  end

  describe "#category_name" do
    it "gets the first category" do
      expect(queue_item.category_name).to  eq(category.name)
    end
  end
end
