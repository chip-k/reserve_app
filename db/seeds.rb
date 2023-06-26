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


2.times do |i|
 Temple.create(
  name: "寺院#{i}",
  name_kana: "ジイン",
  introduction: "寺院#{i}は、〇〇の本願寺をご本山とする〇〇派の寺院です。 報恩講法要（12月）、彼岸会（3月,9月）、永代経法要（4〜5月）、宗祖降誕会（5月）、盂蘭盆会（8月）の各種法要のほか、壮年会、婦人会、子ども会、広報部会、さらには、コーラス、門信徒のつどい、ヨガ教室、グラウンドゴルフ、ゴルフなど、1年を通して様々な活動を行っています。 地域の皆さまが気軽に楽しく足を運んでいただける「敷居の低いお寺」を目指しています。",
  postal_code: "111111#{i}",
  prefecture_code: "東京",
  address: "東京都中央区#{i}",
  email: "temple#{i}@example.com",
  phone_number: "0123456789#{i}",
  password: "11111#{i}",
  password_confirmation: "11111#{i}"
 )
end


3.times do |i|
 User.create(
  name: "ユーザー#{i}",
  name_kana: "ユーザー",
  postal_code: "222222#{i}",
  prefecture_code: "福岡",
  city: "福岡市",
  street: "中央区",
  other_address: "#{i}",
  email: "user#{i}@example.com",
  phone_number: "0987654321#{i}",
  password: "22222#{i}",
  password_confirmation: "22222#{i}"
 )
end