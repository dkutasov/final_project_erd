class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :category_id
      t.integer :trip_id

      t.timestamps

    end
  end
end
