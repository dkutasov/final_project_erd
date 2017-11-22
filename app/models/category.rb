class Category < ApplicationRecord
  # Direct associations

  has_many   :activities,
             :dependent => :destroy

  belongs_to :trip

  belongs_to :user

  # Indirect associations

  has_many   :trips,
             :through => :activities,
             :source => :trip

  # Validations

end
