class EligibleEvents < ActiveRecord::Migration
  def change
    create_table :eligibles_events do |t|
      t.integer :eligible_id
      t.integer :event_id
      end
  end
end
