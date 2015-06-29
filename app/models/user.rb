class User < ActiveRecord::Base
  validates_presence_of :name, :password,:email_address
  validates :password, length: {minimum: 5, maximum: 30}
  validates_uniqueness_of :email_address 
  has_many :reviews
  has_secure_password validations: false
end
