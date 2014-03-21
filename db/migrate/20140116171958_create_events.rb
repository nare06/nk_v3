class CreateEvents < ActiveRecord::Migration
  def self.up
      create_table :events do |t|
      t.string :title
      t.string :organizer
      t.string :location
      t.datetime :sdatetime
      t.datetime :edatetime
      t.string :contact_name
      t.integer :contact_phone
      t.string :email
      t.text   :events_description
      t.string :short_description
      t.integer :user_id
      t.string :venue

      t.timestamps

    end
  end
  def self.down
    drop_table :events
    end
end
