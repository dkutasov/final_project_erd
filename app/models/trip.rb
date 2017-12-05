class Trip < ApplicationRecord
  # Direct associations

  has_many   :itinerary_items,
             :dependent => :destroy

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  has_many   :activities,
             :through => :itinerary_items,
             :source => :activity

  # Validations

  validates :name, :presence => true

end
