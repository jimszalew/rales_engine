require 'rails_helper'

describe "items revenue endpoint" do
  context "items/most_revenue?quantity=x", type: :request do
    it "returns the top x items ranked by total revenue" do
      merchant = create(:merchant)
      customer = create(:customer)
      item1 = create(:item, merchant: merchant)
      item2 = create(:item, merchant: merchant)
      item3 = create(:item, merchant: merchant)
      invoice1 = create(:invoice, merchant: merchant, customer: customer)
      invoice2 = create(:invoice, merchant: merchant, customer: customer)
      invoice3 = create(:invoice, merchant: merchant, customer: customer)
      transaction1 = create(:transaction, invoice: invoice1, result: "success")
      transaction2 = create(:transaction, invoice: invoice2, result: "success")
      transaction3 = create(:transaction, invoice: invoice3, result: "success")
      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1, quantity: 60, unit_price: 20)
      invoice_item2 = create(:invoice_item, invoice: invoice2, item: item2, quantity: 60, unit_price: 10)
      invoice_item3 = create(:invoice_item, invoice: invoice3, item: item3, quantity: 40, unit_price: 30)

      get "/api/v1/items/most_revenue?quantity=2"
      top_items_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_items_json.first["id"]).to eq(item1.id)
      expect(top_items_json.last["id"]).to eq(item3.id)
    end
  end
end
