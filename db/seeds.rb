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
