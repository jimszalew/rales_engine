require 'rails_helper'

describe 'items most items by quantity' do
  context 'items/most_items?quantity', type: :request do
    it 'returns the top x items by total sold' do
      merchant = create(:merchant)
      customer = create(:customer)
      item1 = create(:item, merchant: merchant)
      item2 = create(:item, merchant: merchant)
      item3 = create(:item, merchant: merchant)
      invoice1 = create(:invoice, merchant: merchant, customer: customer)
      invoice2 = create(:invoice, merchant: merchant, customer: customer)
      invoice3 = create(:invoice, merchant: merchant, customer: customer)
      create(:invoice_item, item: item1, invoice: invoice1, quantity: 30)
      create(:invoice_item, item: item2, invoice: invoice2, quantity: 2)
      create(:invoice_item, item: item2, invoice: invoice2, quantity: 300)
      create(:invoice_item, item: item3, invoice: invoice3, quantity: 1)
      create(:transaction, invoice: invoice1, result: "success")
      create(:transaction, invoice: invoice2, result: "success")
      create(:transaction, invoice: invoice3, result: "success")

      get "/api/v1/items/most_items?quantity=2"

      item_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_json.first["id"]).to eq(item2.id)
      expect(item_json.last["id"]).to eq(item1.id)
      expect(item_json.count).to eq(2)
    end
  end
end
