class Appointment < ApplicationRecord
  belongs_to :salon
  belongs_to :customer
  belongs_to :employee, optional: true
  belongs_to :service, optional: true
end