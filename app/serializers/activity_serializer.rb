class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :date, :latitude, :longitude
  has_one :user
end
