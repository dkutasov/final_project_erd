class Trip < ApplicationRecord
  # Direct associations

  belongs_to :activity

  belongs_to :category

  belongs_to :user

  # Indirect associations

  # Validations

end
