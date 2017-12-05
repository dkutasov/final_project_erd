class AddLocationLongitudeToItineraryItem < ActiveRecord::Migration[5.0]
  def change
    add_column :itinerary_items, :location_longitude, :float
  end
end
