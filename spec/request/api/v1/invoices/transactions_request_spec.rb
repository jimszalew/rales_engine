require 'rails_helper'

describe "Invoice's transactions" do
  context '/invoices/:id/transactions', type: :request do
    it 'returns the transactions for the selected invoice' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      create_list(:transaction, 3, invoice: invoice)
      id = invoice.id

      get "/api/v1/invoices/#{id}/transactions"

      json_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_transactions.count).to eq(3)
    end
  end
end
