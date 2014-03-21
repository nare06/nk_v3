class DomainEvents < ActiveRecord::Migration
  def change
   create_table :domains_events do |t|
      t.integer :domain_id
      t.integer :event_id
   end
  end
end
