# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

=begin
1 - Creer les models. Nous n'utiliserons que les models et seeds
rails new Doctolib
rails g model Doctor first_name:string last_name:string  specialty:string zip_code:string
rails g  model Patient  first_name:string  last_name:string
rails g model Appointment date:datetime

2 - creer les relations Appointment -> Doc/Patients N-1 et Doc-patients -> N-N
Ajoute dans la migration Appointments
	t.belongs_to :doctor, index: true
	t.belongs_to :patient, index: true

3- Migration des fichiers pour creer les tables
rails db:migrate
rails db:migrate:status

4- lier les models entre eux : 1 rdv ∈ 1 docteur, 1 rdv ∈ 1 patient, 1 docteur = N rdv, 1 docteur = N patients.rdv, 1 patient = N rdv, 1 patient = N docteur.rdv

Doc Appointments 

class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
end

class Doctor < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments
end

class Patient < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments
end

5- Test des models
>d = Doctor.create
>p = Patient.create
>a = Appointment.create(doctor: d, patient: p)
a.doctor
a.patient
d.patients
p.doctors
=end
require 'faker'

City.create!(name: "Berlin")
City.create!(name: "Londes")
City.create!(name: "Paris")
City.create!(name: "Pékin")

puts "4 villes crees"

p "#{tp City.all}"

Specialty.create!(name:"generaliste")
Specialty.create!(name:"osteopathe") 
Specialty.create!(name:"ophtalmologiste")
Specialty.create!(name:"dentiste") 

puts "Speciality crees"
p "#{tp Specialty.all}"

5.times do
  Patient.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, city_id: 2 )#City.find(rand(1..4)))
end
puts "5 patients la liste"
p "#{tp Patient.all}"

5.times do
  Doctor.create!(first_name: "Dr.#{Faker::Name.first_name}", last_name: Faker::Name.last_name, city_id: 1, specialty_id: Specialty.find(rand(1..4))) #city_id: City.find(rand(1..4))
end
puts "5 docteurs dans la liste"
p "#{tp Doctor.all}"


10.times do 
  Appointment.create!(date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now), doctor: Doctor.find(rand(1..5)), patient: Patient.find(rand(1..5)), city_id:1) #City.find(rand(1..4)))
end
puts "10 rdv on ete crees"

=begin
4. Petit coup de boost
tu aimerais ajouter plusieurs tables ; 
1 city = N doctor, N patient
Supprimer specialty de docteur
Creer Model specialty 
N specialty = N doctor

-> On enleve specialty et zip_code de Doctor
-> on creer deux modeles avec City relation 1-N et Specialty relation N-N

City
-> On lie les tables entre elles. Comme Patient et Doctor sont deja crees on fait
rails generate migration AddIndexToDoctorandPatient (cf dans db)
-> On lie maintenant les models :  belongs_to :city et City = has many :doctors :patients

A- 
=end