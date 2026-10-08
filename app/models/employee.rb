class Employee < ApplicationRecord
  belongs_to :salon
  has_many :appointments, dependent: :nullify
end
