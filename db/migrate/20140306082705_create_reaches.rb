class CreateReaches < ActiveRecord::Migration
  def change
    create_table :reaches do |t|
      t.string :name
      t.timestamps
    end
  end
end
