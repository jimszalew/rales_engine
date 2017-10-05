class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def customers_with_pending_invoices
    Customer.find_by_sql "SELECT customers.*
                          FROM customers
                          INNER JOIN (SELECT invoices.*
                                      FROM invoices
                                      INNER JOIN transactions
                                      ON invoices.id=transactions.invoice_id
                                      WHERE result='failed'
                                      GROUP BY invoices.id
                                      EXCEPT
                                      SELECT invoices.* FROM invoices
                                      INNER JOIN transactions
                                      ON invoices.id=transactions.invoice_id
                                      WHERE result='success'
                                      GROUP BY invoices.id)
                                      AS pending_invoices
                                      ON customers.id=pending_invoices.customer_id
                                      WHERE merchant_id=#{self.id}
                                      ORDER BY customers.id"
  end

  def favorite_customer
    customers.joins(:transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order('count(*) DESC')
    .first
  end

  def find_revenue(date = nil)
    invoices.joins(:invoice_items, :transactions)
    .merge(Invoice.date_match(date))
    .merge(Transaction.successful)
    .sum("quantity * unit_price")
  end

  def self.total_revenue(date = nil)
    joins(invoices: [:invoice_items, :transactions])
    .select("sum(invoice_items.unit_price * invoice_items.quantity) AS total")
    .where(invoices: {created_at: date})
    .merge(Transaction.successful)[0].total
  end

  def self.top_merchants(quantity = nil)
    select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS totes_rev")
    .joins(:transactions, :invoice_items)
    .group(:id)
    .order("totes_rev DESC")
    .limit(quantity)
  end
end
