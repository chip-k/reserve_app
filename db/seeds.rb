# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Admin.find_or_create_by(id: 1) do |admin|
 admin = Admin.find(1)
 admin.name = "西圓寺"
 admin.email = "example@example.com"
 admin.password = "example"
 admin.phone_number = "093-282-6765"
 admin.postal_code = "8114205"
 admin.address = "福岡県遠賀郡岡垣町三吉869"
 if admin.save
 end
#end