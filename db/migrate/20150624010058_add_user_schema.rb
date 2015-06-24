class AddUserSchema < ActiveRecord::Migration
  def change
    create_table :users do |f|
      f.string :email_address
      f.string :password_digest
      f.string :name
    end
  end
end
