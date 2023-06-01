# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Admin.find_or_create_by(id: 1) do |admin|
 admin = Admin.find(1)
 admin.name = "他力本願寺"
 admin.email = "example@example.com"
 admin.password = "example"
 admin.phone_number = "012-345-6789"
 admin.postal_code = "1234567"
 admin.address = "日本県日本市日本区日本1-2-3"
 if admin.save
 end
#end