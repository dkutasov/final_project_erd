class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :length

      t.timestamps

    end
  end
end
