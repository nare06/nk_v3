class LinkEligibleUsers < ActiveRecord::Migration
  def change
   create_table :eligibles_users do |t|
      t.integer :eligible_id
      t.integer :user_id
      end
  end
end
