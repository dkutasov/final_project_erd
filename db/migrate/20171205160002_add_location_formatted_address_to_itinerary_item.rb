class AddLocationFormattedAddressToItineraryItem < ActiveRecord::Migration[5.0]
  def change
    add_column :itinerary_items, :location_formatted_address, :string
  end
end
