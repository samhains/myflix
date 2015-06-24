require 'spec_helper'

describe User do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:email_address)}
  it {should validate_uniqueness_of(:email_address)}
  it {should validate_length_of(:password).is_at_least(5).is_at_most(30)}
end
