class User < ApplicationRecord
  # Direct associations

  has_many   :trips,
             :dependent => :destroy

  # Indirect associations

  has_many   :categories,
             :through => :trips,
             :source => :category

  has_many   :activities,
             :through => :trips,
             :source => :activity

  # Validations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
