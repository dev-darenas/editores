# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ======================================= ROLES =======================================
roles = [:admin, :seller, :collector]

Role.delete_all
ActiveRecord::Base.connection.execute("TRUNCATE roles")
p "################# creating roles #################"
roles.each_with_index do |name, index|
  Role.create(id: (index+1), name: name)
end