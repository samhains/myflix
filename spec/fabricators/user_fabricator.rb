Fabricator(:user) do
  name {Faker::Name.name}
  email_address {Faker::Internet.email}
  password "12345"
end
