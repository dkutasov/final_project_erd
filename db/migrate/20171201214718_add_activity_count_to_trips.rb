class AddActivityCountToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :activities_count, :integer
  end
end
