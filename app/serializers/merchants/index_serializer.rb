class Merchants::IndexSerializer < ActiveModel::Serializer
  attributes :created_at, :id, :name, :updated_at
end
