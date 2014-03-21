class ChangeEventMobilenoToString < ActiveRecord::Migration
  def self.up
  change_column :events, :contact_phone, :string
  end
  def self down
  change_column :event, :contact_phone, :integer
  end
end
