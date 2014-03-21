class CreateEligibles < ActiveRecord::Migration
  def change
    create_table :eligibles do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
