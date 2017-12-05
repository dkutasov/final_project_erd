class AddPreferenceCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :preferences_count, :integer
  end
end
