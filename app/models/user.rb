class User < ApplicationRecord
  # Direct associations

  has_many   :preferences,
             :dependent => :destroy

  has_many   :trips,
             :dependent => :destroy

  # Indirect associations

  has_many   :categories,
             :through => :preferences,
             :source => :category

  # Validations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
