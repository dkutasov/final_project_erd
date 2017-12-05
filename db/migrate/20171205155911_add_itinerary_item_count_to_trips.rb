class AddItineraryItemCountToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :itinerary_items_count, :integer
  end
end
