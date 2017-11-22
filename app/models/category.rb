class Category < ApplicationRecord
  # Direct associations

  has_many   :trips,
             :dependent => :destroy

  # Indirect associations

  has_many   :users,
             :through => :trips,
             :source => :user

  # Validations

end
