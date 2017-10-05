class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoice_items

  def self.most_rev(quantity = nil)
    select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total")
      .joins(invoices: :transactions)
      .group(:id)
      .order("total DESC")
      .limit(quantity)
  end
end
