class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    object.name.capitalize
  end
end
