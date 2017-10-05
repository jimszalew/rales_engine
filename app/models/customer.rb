class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants.joins(:transactions)
    .merge(Transaction.successful)
    .group(:id, :name).order("count(*) desc").first
  end
end
