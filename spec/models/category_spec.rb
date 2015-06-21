require 'spec_helper'


describe Category do
  it "it can save itself" do
    category = Category.new(name: 'Action')
    category.save
    expect(Category.first).to eq(category)
  end
  it "can have many videos" do
    videos = Video.create([
    {title: 'Speed', description: 'Action Flick'}, 
    {title: 'Mission Impossible', description: 'Another Action Flick'}])
    category = Category.create(name: 'Action', videos: videos)
    expect(category.videos).to eq(videos)
  end
end