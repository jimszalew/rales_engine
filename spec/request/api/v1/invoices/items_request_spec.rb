require 'rails_helper'

describe "Invoice's items" do
  context '/invoices/:id/items', type: :request do
    it 'returns the items for the selected invoice' do
      merchant = create(:merchant)
      customer = create(:customer)
      items = create_list(:item, 3, merchant: merchant)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      create(:invoice_item, item: items[0], invoice: invoice)
      create(:invoice_item, item: items[1], invoice: invoice)
      create(:invoice_item, item: items[2], invoice: invoice)
      id = invoice.id

      get "/api/v1/invoices/#{id}/items"

      json_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_items.count).to eq(3)
      expect(json_items.first["name"]).to eq(items.first.name)
    end
  end
end
