require 'rails_helper'

describe 'Merchants revenue' do
  context 'merchants/:id/revenue', type: :request do
    it 'returns single merchants total revenue from all transactions' do
      customer = create(:customer)
      merchant = create(:merchant)
      id = merchant.id
      item = create(:item, merchant: merchant)
      invoice1 = create(:invoice, merchant: merchant, customer: customer)
      invoice2 = create(:invoice, merchant: merchant, customer: customer)
      invoice3 = create(:invoice, merchant: merchant, customer: customer)
      transaction1 = create(:transaction, invoice: invoice1, result: "success")
      transaction2 = create(:transaction, invoice: invoice2, result: "success")
      transaction3 = create(:transaction, invoice: invoice3, result: "success")
      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item, quantity: 50, unit_price: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice2, item: item, quantity: 40, unit_price: 10)
      invoice_item3 = create(:invoice_item, invoice: invoice3, item: item, quantity: 30, unit_price: 10)

      get "/api/v1/merchants/#{id}/revenue"

      json_revenue = JSON.parse(response.body, quirks_mode: true)

      expect(response).to be_success
      expect(json_revenue["revenue"]).to eq("12.0")
    end
  end
end
