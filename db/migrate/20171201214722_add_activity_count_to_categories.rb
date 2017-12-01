class AddActivityCountToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :activities_count, :integer
  end
end
