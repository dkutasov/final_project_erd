class Category < ApplicationRecord
  # Direct associations

  has_many   :activities,
             :dependent => :nullify

  # Indirect associations

  has_many   :users,
             :through => :activities,
             :source => :user

  # Validations

end
