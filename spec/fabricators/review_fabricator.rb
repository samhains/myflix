Fabricator(:review) do
  rating { rand(1..5) }
  description { Faker::Lorem.paragraph(2) }
  creator { Fabricate(:user) } 
  video
end
