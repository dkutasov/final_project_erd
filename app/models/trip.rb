class Trip < ApplicationRecord
  # Direct associations

  has_many   :activities,
             :dependent => :destroy

  has_many   :preferences,
             :class_name => "Category",
             :dependent => :destroy

  # Indirect associations

  # Validations

end
