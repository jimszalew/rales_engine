require 'rails_helper'

describe "merchants most items by quantity" do
  context "merchants/most_items?quantity=x", type: :request do
    it "returns top x merchants ranked by total number of items sold" do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)
      item3 = create(:item, merchant: merchant3)
      invoice1 = create(:invoice, merchant: merchant1, customer: customer)
      invoice2 = create(:invoice, merchant: merchant2, customer: customer)
      invoice3 = create(:invoice, merchant: merchant2, customer: customer)
      create(:transaction, invoice: invoice1, result: "success")
      create(:transaction, invoice: invoice2, result: "success")
      create(:transaction, invoice: invoice2, result: "success")
      create(:invoice_item, invoice: invoice1, item: item1, quantity: 50)
      create(:invoice_item, invoice: invoice2, item: item2, quantity: 2)
      create(:invoice_item, invoice: invoice2, item: item2, quantity: 600)
      create(:invoice_item, invoice: invoice3, item: item3, quantity: 1)

      get "/api/v1/merchants/most_items?quantity=2"

      most_items_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(most_items_json.first["id"]).to eq(merchant2.id)
      expect(most_items_json.last["id"]).to eq(merchant1.id)
      expect(most_items_json.count).to eq(2)
    end
  end
end
