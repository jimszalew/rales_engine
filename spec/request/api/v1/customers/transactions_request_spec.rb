require 'rails_helper'

describe "Customers transactions" do
  context '/customers/:id/transactions', type: :request do
    it 'returns the merchant for the selected item' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      create_list(:transaction, 3, invoice: invoice)
      id = customer.id

      get "/api/v1/customers/#{id}/transactions"

      json_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_transactions.count).to eq(3)
    end
  end
end
