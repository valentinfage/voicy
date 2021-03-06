# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
actor_count = 1
puts 'Creating 10 fake actors...'
10.times do
  actor = User.new(
    first_name:      Faker::Name.first_name,
    last_name:       Faker::Name.last_name,
    email:           Faker::Internet.email,
    password:        Faker::Internet.password(10, 20, true),
    birthday:        Faker::Date.birthday(18, 65),
    website:         Faker::Internet.url,
    role:            1,
    gender:          Faker::Number.between(0, 1).to_i,
    phone_number:    Faker::PhoneNumber.phone_number,
    voice_attribute: Faker::Number.between(0, 2).to_i,
    description:     Faker::Lorem.paragraph,
    avaibility:      Faker::Boolean.boolean(0.2),
    address:         Faker::Address.street_address,
    zip_code:        Faker::Address.zip_code,
    city:            Faker::Address.city

  )
  photo = Faker::LoremPixel.image
  actor.photos = Cloudinary::Uploader.upload(photo)
  actor.save!
  puts "#{actor_count} actors created !"
  actor_count += 1
end
 da_count = 1
puts 'Creating 5 fake DA with him project...'
5.times do
  da = User.new(
    first_name:      Faker::Name.first_name,
    last_name:       Faker::Name.last_name,
    email:           Faker::Internet.email,
    password:        "031088",
    birthday:        Faker::Date.birthday(18, 65),
    website:         Faker::Internet.url,
    role:            0,
    gender:          Faker::Number.between(0, 1).to_i,
    phone_number:    Faker::PhoneNumber.phone_number,
    address:         Faker::Address.street_address,
    zip_code:        Faker::Address.zip_code,
    city:            Faker::Address.city

  )
  photo = Faker::LoremPixel.image
  da.photos = Cloudinary::Uploader.upload(photo)
  da.save!
  puts "#{da_count} da created !"
  da_count += 1
  pro = Project.create(name: Faker::Pokemon.name, description: Faker::Lorem.paragraph,
                       begin: Faker::Date.backward(30), end: Faker::Date.forward(30),
                       user_id: da.id, category: Faker::Number.between(0, 1).to_i)
  pro.users = User.where(role: "actor").limit(10)
  pro.save!
  puts "project created at #{da.first_name} DA !"
end
