class InvoiceItemSerializer < ActiveModel::Serializer
  attributes  :id, :invoice_id, :item_id, :quantity, :unit_price

  def unit_price
    ((object.unit_price.to_i) / 100.00).to_s
  end
end
