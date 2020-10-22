class AddIndexToDoctorandPatient < ActiveRecord::Migration[6.0]
  def change
      add_reference :doctors, :city, foreign_key: true
      add_reference :patients, :city, foreign_key: true
      add_reference :appointments, :city, foreign_key: true
  end
end
