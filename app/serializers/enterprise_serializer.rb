class EnterpriseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_one :country
end
