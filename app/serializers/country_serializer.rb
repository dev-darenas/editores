class CountrySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :departments

  def name
    object.name.capitalize
  end
end
