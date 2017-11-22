class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :trip_id
      t.integer :category_id

      t.timestamps

    end
  end
end
