class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :category_id
      t.integer :trip_id
      t.string :name
      t.string :location
      t.integer :user_id

      t.timestamps

    end
  end
end
