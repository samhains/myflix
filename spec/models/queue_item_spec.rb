require 'spec_helper'

describe QueueItem do
  let(:user) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }
  let(:review) { Fabricate(:review, video: video, creator: user ) }
  let(:queue_item) { Fabricate(:queue_item, video: video, user: user) }
  let(:category) { video.categories.first }

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
