class CreatePushids < ActiveRecord::Migration
def self.up
    create_table :pushids do |t|
      t.integer :user_id
      t.integer :event_id
      t.string  :fbpush_id
      t.string  :gcpush_id
      t.string  :gcpush_htmllink
      t.string  :fbpush_htmllink      

      t.timestamps
    end
  end
  def self.down
   drop_table :pushids
  end
end
