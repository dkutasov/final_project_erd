class User < ApplicationRecord
  # Direct associations

  has_many   :activities,
             :dependent => :destroy

  # Indirect associations

  has_many   :trips,
             :through => :activities,
             :source => :trip

  has_many   :categories,
             :through => :activities,
             :source => :category

  # Validations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
