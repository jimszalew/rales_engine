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

  context "merchants/:id/revenue?date", type: :request do
    it "returns the total revenue for merchant by date" do
      customer = create(:customer)
      merchant = create(:merchant)
      id = merchant.id
      item = create(:item, merchant: merchant)
      invoice1 = create(:invoice, merchant: merchant, customer: customer, created_at: "2012-03-10 00:54:09 UTC")
      invoice2 = create(:invoice, merchant: merchant, customer: customer, created_at: "2012-03-10 00:54:09 UTC")
      invoice3 = create(:invoice, merchant: merchant, customer: customer, created_at: "2012-03-11 00:54:09 UTC")
      transaction1 = create(:transaction, invoice: invoice1, result: "success")
      transaction2 = create(:transaction, invoice: invoice2, result: "success")
      transaction3 = create(:transaction, invoice: invoice3, result: "success")
      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item, quantity: 50, unit_price: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice2, item: item, quantity: 40, unit_price: 10)
      invoice_item3 = create(:invoice_item, invoice: invoice3, item: item, quantity: 30, unit_price: 10)

      get "/api/v1/merchants/#{id}/revenue?date=#{invoice1.created_at}"

      revenue_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(revenue_json["revenue"]).to eq("9.0")
    end
  end

  context "merchants/revenue?date", type: :request do
    it "returns the total revenue for a date across all merchants" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      customer = create(:customer)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)
      item3 = create(:item, merchant: merchant3)
      invoice1 = create(:invoice, merchant: merchant1, customer: customer, created_at: "2012-03-11 00:54:09 UTC")
      invoice2 = create(:invoice, merchant: merchant2, customer: customer, created_at: "2012-03-11 00:54:09 UTC")
      invoice3 = create(:invoice, merchant: merchant3, customer: customer, created_at: "2012-03-12 00:54:09 UTC")
      transaction1 = create(:transaction, invoice: invoice1, result: "success")
      transaction2 = create(:transaction, invoice: invoice2, result: "success")
      transaction3 = create(:transaction, invoice: invoice3, result: "success")
      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1, quantity: 60, unit_price: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice2, item: item2, quantity: 50, unit_price: 20)
      invoice_item3 = create(:invoice_item, invoice: invoice3, item: item3, quantity: 40, unit_price: 30)

      get "/api/v1/merchants/revenue?date=#{invoice1.created_at}"

      revenue_json = JSON.parse(response.body)

      expect(response).to be_success
      expect(revenue_json["total_revenue"]).to eq("16.0")
    end
  end
end
