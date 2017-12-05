class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :category_id
      t.integer :activity_id
      t.date :beginning_date
      t.date :ending_date
      t.integer :user_id
      t.string :name

      t.timestamps

    end
  end
end
