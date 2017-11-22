class Activity < ApplicationRecord
  # Direct associations

  belongs_to :category

  belongs_to :trip

  # Indirect associations

  # Validations

end
