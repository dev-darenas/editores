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


user = User.find_by(email: 'superadmin@editorial.com')

unless user.present?
  u = User.new(
    firstname: 'User',
    lastname: 'Admin',
    cellphone: '123456789',
    email: 'superadmin@editorial.com',
    password: 'Editorial2019@superadmin',
    password_confirmation: 'Editorial2019@superadmin'
  )
  u.add_role :admin
  u.save!
end

# ================================= COUNTRIES, DEPARTMENTS, CITIES ====================================

countries = [
  {
    country: {
      name: "colombia",
      departments: [
        {
          name: "bolivar",
          cities: [
            "cartagena"
          ]
        },
        {
          name: "valle del cauca",
          cities: [
            "cali",
            "palmira",
            "tulua"
          ]
        }
      ]
    }
  },
  {
    country: {
      name: "ecuador",
      departments: [
        {
          name: "santo domingo tsachilas",
          cities: [
            "santo domingo de los colorados"
          ]
        }
      ]
    }
  }

]

if false
  City.delete_all
  Department.delete_all
  Country.delete_all
  ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS = 0")
  ActiveRecord::Base.connection.execute("TRUNCATE cities")
  ActiveRecord::Base.connection.execute("TRUNCATE departments")
  ActiveRecord::Base.connection.execute("TRUNCATE countries")
  ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS = 1")
  p "################# creating countries, departments and cities #################"

# TODO: get error => Duplicate entry '1' for key 'PRIMARY': INSERT INTO `departments` (`id`, `country_id`, `name`, `created_at`, `updated_at`) VALUES (1, 2, 'santo domingo tsachilas', '2019-04-09 15:33:13', '2019-04-09 15:33:13')

  countries.each_with_index do |country, c_index|
    c = Country.create(id: (c_index+1), name: country[:country][:name])
    country[:country][:departments].each_with_index do |department, d_index|
      dpto = c.departments.create(id: d_index+1, name: department[:name])
      department[:cities].each do |city|
        dpto.cities.create(name: city)
      end
    end
  end
end


