class AddLocationLatitudeToItineraryItem < ActiveRecord::Migration[5.0]
  def change
    add_column :itinerary_items, :location_latitude, :float
  end
end
