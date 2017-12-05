class Preference < ApplicationRecord
  # Direct associations

  belongs_to :category

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations

  validates :category_id, :presence => true

  validates :name, :presence => true

  validates :user_id, :presence => true

end
