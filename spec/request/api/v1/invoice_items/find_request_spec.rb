require 'rails_helper'

describe 'Find invoice_items' do
  context '/invoice_items/find?parameters', type: :request do
    it 'returns the invoice_item specified by id' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      invoice_item = create(:invoice_item, item: item, invoice: invoice)

      get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

      json_invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoice_item["id"]).to eq(invoice_item.id)
    end
  end

  context '/invoice_items/find_all?parameters', type: :request do
    it 'returns all invoice_items matching the quantity' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      invoice_item1 = create_list(:invoice_item, 3, quantity: 12, item: item, invoice: invoice)
      invoice_item2 = create_list(:invoice_item, 2, quantity: 14, item: item, invoice: invoice)

      get "/api/v1/invoice_items/find_all?quantity=#{invoice_item1.first.quantity}"

      json_invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_invoice_items.count).to eq(3)
      expect(json_invoice_items.first["quantity"]).to eq(invoice_item1.first.quantity)
    end
  end
end
