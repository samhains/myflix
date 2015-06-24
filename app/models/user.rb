class User < ActiveRecord::Base
  validates_presence_of :name, :password,:email_address
  has_secure_password
end
