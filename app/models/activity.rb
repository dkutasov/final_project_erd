class Activity < ApplicationRecord
  # Direct associations

  has_many   :itinerary_items,
             :dependent => :destroy

  belongs_to :category,
             :counter_cache => true

  # Indirect associations

  has_many   :trips,
             :through => :itinerary_items,
             :source => :trip

  # Validations

  validates :category_id, :presence => true

  validates :name, :uniqueness => { :scope => [:category_id] }

  validates :name, :presence => { :message => "Please enter a name for this activity" }

end
