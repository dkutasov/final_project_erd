class Trip < ApplicationRecord
  # Direct associations

  has_many   :activities,
             :dependent => :destroy

  # Indirect associations

  has_many   :users,
             :through => :activities,
             :source => :user

  # Validations

end
