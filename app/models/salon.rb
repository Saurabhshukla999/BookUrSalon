class Salon < ApplicationRecord
  has_many :customers, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :appointments, dependent: :destroy

  validates :name, presence: true
end
