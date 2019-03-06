class DueSerializer < ActiveModel::Serializer
  attributes :id, :name, :periodicity, :interests
end
