class CreateAuthorizations < ActiveRecord::Migration
  def self.up
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid, :unique => true
      t.integer :user_id
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
  def self.down
    drop_table :authorizations
    end 
end
