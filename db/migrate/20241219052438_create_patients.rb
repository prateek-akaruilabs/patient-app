class CreatePatients < ActiveRecord::Migration[7.2]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :email
      t.date :dob
      t.datetime :next_appointment_date
      t.timestamps
    end
  end
end
