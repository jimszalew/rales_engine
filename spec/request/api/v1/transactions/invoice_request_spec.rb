require 'rails_helper'

describe "Transactions invoice" do
  context '/transactions/:id/invoice', type: :request do
    it 'returns the invoice for the selected transaction' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      transaction = create(:transaction, invoice: invoice)
      id = transaction.id

      get "/api/v1/transactions/#{id}/invoice"

      json_invoice = JSON.parse(response.body)

      expect(response).to be_success
    end
  end
end
