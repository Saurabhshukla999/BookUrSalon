class Customer < ApplicationRecord
  belongs_to :salon, optional: true
  has_many :appointments, dependent: :destroy

  validates :name, :phone, presence: true
end
