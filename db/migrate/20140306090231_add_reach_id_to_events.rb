class AddReachIdToEvents < ActiveRecord::Migration
  def change
  add_column :events, :reach_id, :integer
  end
end
