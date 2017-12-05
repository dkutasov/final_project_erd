class AddTripCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :trips_count, :integer
  end
end
