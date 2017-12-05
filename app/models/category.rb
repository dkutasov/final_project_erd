class Category < ApplicationRecord
  # Direct associations

  has_many   :preferences,
             :dependent => :destroy

  has_many   :activities,
             :dependent => :destroy

  # Indirect associations

  has_many   :users,
             :through => :preferences,
             :source => :user

  # Validations

  validates :name, :uniqueness => true

  validates :name, :presence => { :message => "Please enter a category name" }

end
