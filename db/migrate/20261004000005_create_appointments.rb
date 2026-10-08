class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :salon, foreign_key: true
      t.references :customer, foreign_key: true
      t.references :employee, foreign_key: true
      t.references :service, foreign_key: true

      t.timestamps
    end
  end
end
