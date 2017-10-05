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

  def self.total_revenue
    joins(invoices: [:invoice_items, :transactions])
    .select("sum(invoice_items.unit_price * invoice_items.quantity) as total")
    .merge(Transaction.successful)[0].total
  end
end
