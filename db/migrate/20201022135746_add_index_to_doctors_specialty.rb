class AddIndexToDoctorsSpecialty < ActiveRecord::Migration[6.0]
  def change
    add_reference :doctors, :specialty, foreign_key: true
    add_reference :specialties, :doctor, foreign_key: true
  end
end
