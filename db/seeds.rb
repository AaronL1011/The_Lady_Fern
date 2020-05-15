# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user = User.create(
#     name: "Sophia97",
#     billing_address: "60 Test Ave, Rhode Island",
#     shipping_address: "60 Test Ave, Rhode Island",
#     phone_number: "0410 110 011"
# )
# p "Created User!"

user = User.new
user.email = "admin@email.com"
user.name = "Sophia97"
user.phone_number = "0410101110"
user.shipping_address = "60 Test Ave, Rhode Island"
user.password = "password"
user.encrypted_password = "$2a$11$E8NwtuglMQSvVYi.Ar/jvuWu.MBZ0XcEzjumKnWEmbliTlamXzAXG"
user.admin = 1
user.save!
p "Created Admin User"


for i in 1..6
    User.first.listings.create(
        title: "Bouquet#{i}",
        description: "A small bouquet arrangement made up of Kangaroo Paw, Grevillea, Bottlebrushes and Wattle. ",
        price: 15.00,
        size: "Small",
        in_stock: true
    )
    p "Created #{i} listings!"
end
