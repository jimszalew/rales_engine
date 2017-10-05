class ItemSerializer < ActiveModel::Serializer
  attributes :description, :id, :merchant_id, :name, :unit_price

  def unit_price
    ((object.unit_price.to_i) / 100.00).to_s
  end
end
