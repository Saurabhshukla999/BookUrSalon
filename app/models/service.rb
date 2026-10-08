class Service < ApplicationRecord
  belongs_to :salon
  has_many :appointments, dependent: :nullify

  validates :name, presence: true
end
