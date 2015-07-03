require 'spec_helper'

describe QueueItem do
  let(:queue_item) { Fabricate(:queue_item) }
  let(:video) { queue_item.video }
  let(:review) { queue_item.review }
  let(:user) { queue_item.user }
  let(:category) { video.categories.first }

  it { should belong_to(:video) }
  it { should belong_to(:user) }
  it { should belong_to(:review) }

  describe "#video_title" do
    it "should get the video title" do
      expect(queue_item.video_title).to eq(video.title)
    end
  end

  describe "#video_title" do
    it "should get the video title" do
      expect(queue_item.video_title).to eq(video.title)
    end
  end
  
  describe "#rating" do
    it "should get the review rating" do
      expect(queue_item.rating).to eq(review.rating)
    end
  end

  describe "#category" do
    it "should get the first category" do
      expect(queue_item.category).to  eq(category)
    end
  end

  describe "#category_name" do
    it "should get the first category" do
      expect(queue_item.category_name).to  eq(category.name)
    end
  end
end
