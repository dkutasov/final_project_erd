class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :category_id
      t.integer :user_id
      t.string :name

      t.timestamps

    end
  end
end
