class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :cities


  def name
    object.name.capitalize
  end

  def cities
    object.cities
  end
end
