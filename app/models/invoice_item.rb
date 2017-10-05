class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoice_items, source: :items

  def self.dollar_to_cents_all(params)
    where(unit_price: params.gsub!(/[^0-9A-Za-a]/,''))
  end


  def self.dollar_to_cents_one(params)
    find_by(unit_price: params.gsub!(/[^0-9A-Za-a]/,''))
  end
end
