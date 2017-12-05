class CreateItineraryItems < ActiveRecord::Migration
  def change
    create_table :itinerary_items do |t|
      t.integer :activity_id
      t.integer :trip_id
      t.string :name
      t.string :location

      t.timestamps

    end
  end
end
