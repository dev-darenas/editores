class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :name, :role, :email

  def role
    object.roles.first.name
  end

  def full_name
    object.full_name
  end

  # necesario para el select de asesor y cobrador en el front, mejorar esto para usar solo name y no full_name
  def name
    object.full_name
  end
end
