class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
          t.integer :user_id
      t.integer :event_id
    end
  end
end
