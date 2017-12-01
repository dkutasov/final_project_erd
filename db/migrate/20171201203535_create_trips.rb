class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :length
      t.integer :category_id
      t.integer :user_id
      t.integer :activity_id

      t.timestamps

    end
  end
end
