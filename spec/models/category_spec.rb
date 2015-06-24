require 'spec_helper'


describe Category do
  it {should have_many(:videos)}
  describe "#recent_videos" do

    it "returns empty array if category has no videos" do
      comedy = Category.create(name: 'Comedy') 
      expect(comedy.recent_videos).to eq([])
    end

    it "returns array in reverse chronological order" do
      action = Category.create(name: 'Action') 
      wop_gun = Video.create(title: 'Wop Gun', description: 'Action Flick', categories: [action],created_at: 3.day.ago)
      vop_gun = Video.create(title: 'Vop Gun', description: 'Action Flick', categories: [action],created_at: 2.day.ago)
      pop_gun = Video.create(title: 'Pop Gun', description: 'Action Flick', categories: [action],created_at: 1.day.ago)
      expect(action.recent_videos).to eq([ pop_gun, vop_gun, wop_gun ])
    end

    it "returns all the videos if there are less than 6" do
      action = Category.create(name: 'Action') 
      wop_gun = Video.create(title: 'Wop Gun', description: 'Action Flick', categories: [action])
      vop_gun = Video.create(title: 'Vop Gun', description: 'Action Flick', categories: [action])
      pop_gun = Video.create(title: 'Pop Gun', description: 'Action Flick', categories: [action])
      expect(action.recent_videos).to eq([ pop_gun, vop_gun, wop_gun ])
      
    end

    it "returns array of only 6 most recent videos" do
      
      action = Category.create(name: 'Action') 
      old_film =   Video.create(title: 'boo', description: 'Action Flick', categories: [action])
      7.times {  Video.create(title: 'foo', description: 'Action Flick', categories: [action])} 
      expect(action.recent_videos).to_not include(old_film)
      expect(action.recent_videos.count).to eq(6)
    end
    

  end
end
