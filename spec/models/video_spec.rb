require 'spec_helper'

describe Video do

  it {should have_many(:categories)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  
  describe "search_by_title" do
            
    it "returns empty array if search finds no video" do
      Video.create([{title: 'South Park', description: 'Funny'}, 
                             {title:'South Lawn', description: 'Not Funny'}])
      expect(Video.search_by_title('hello')).to eq([])
    end
    
    it "returns single video array if there is a single match" do
      Video.create({title:'South Lawn', description: 'Not Funny'})
      south_park = Video.create({title: 'South Park', description: 'Funny'})
      expect(Video.search_by_title('South Park')).to eq([south_park])
    end

    it "returns single video array if there is a partial match" do
      Video.create({title:'South Lawn', description: 'Not Funny'})
      south_park = Video.create({title: 'South Park', description: 'Funny'})
      expect(Video.search_by_title('Park')).to eq([south_park])
      expect(Video.search_by_title('South P')).to eq([south_park])
    end

    it "returns array of matching videos if matches in order created_by" do
      south_lawn = Video.create({title:'South Lawn', description: 'Not Funny' })
      south_park = Video.create({title: 'South Park', description: 'Funny'})
      expect(Video.search_by_title('South')).to eq([south_park,south_lawn])
    end
    
    it "returns an empty array for a search with an empty string" do
      Video.create({title:'South Lawn', description: 'Not Funny' })
      Video.create({title: 'South Park', description: 'Funny'})
      expect(Video.search_by_title("")).to eq([])
    end
    
  end


end
