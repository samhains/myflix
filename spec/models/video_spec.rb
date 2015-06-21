require 'spec_helper'


describe Video do
  it "it can save itself" do
    video = Video.new(title: 'Speed', description: 'Action Flick')
    video.save
    expect(Video.first).to eq(video)
  end

  it "can have many categories" do
    categories = Category.create([{name: 'Action'}, {name: 'Drama'}])
    Video.create(title: 'Speed', description: 'Action Flick', categories: categories)
    expect(Video.first.categories).to eq(categories)
  end
end