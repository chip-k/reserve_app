# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.find_or_create_by(id: 1) do |admin|
 #admin = Admin.find(1)
 admin.name = "TempleConnect Online運営"
 admin.email = "example@example.com"
 admin.password = "example"
 admin.phone_number = "01234567890"
 admin.postal_code = "1234567"
 admin.address = "大阪府大阪市中央区"
 admin.save
end