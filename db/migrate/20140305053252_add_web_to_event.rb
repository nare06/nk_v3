class AddWebToEvent < ActiveRecord::Migration
  def change
  add_column :events, :web, :string
  end
end
