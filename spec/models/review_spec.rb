require 'spec_helper'

describe Review do
  it { should belong_to(:video) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:rating) }

  describe ".most_recent_review" do
    it "returns most recent review" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review_old = Fabricate(:review, creator: user, video: video, created_at: 2.weeks.ago)
      review_new = Fabricate(:review, creator: user, video: video)
      expect(Review.most_recent_review(user.id, video.id)).to eq(review_new)
    end
  end
end
